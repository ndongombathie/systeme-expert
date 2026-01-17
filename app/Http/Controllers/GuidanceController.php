<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class GuidanceController extends Controller
{
    public function getUes($filiere, $niveau)
    {
        return response()->json(config("ufr_set.$filiere.$niveau") ??[]);
    }

    /**
     * Parse a Prolog list string into a PHP array.
     * Example: "[item1, item2, item3]" becomes ["item1", "item2", "item3"]
     */
    private function parsePrologList($prologList)
    {
        $prologList = trim($prologList, '[]');
        $items = explode(',',$prologList);
        // Remove quotes from items and clean up
        $cleanedItems = [];
        foreach ($items as $item) {
            $item = trim($item);
            if ($item !== '') {
                $cleanedItems[] = $item;
            }
        }
        return $cleanedItems;
    }

    public function analyse(Request $request)
    {
        $asserts = [];
        foreach ($request->ues as $ue) {
            foreach ($ue['ecs'] as $ec) {
                $ecName = $ec['nom'];
                $asserts[] = "assert(ec({$ue['code']}, '{$ecName}', {$ec['note']}))";
            }
        }

        $facts = implode(",", $asserts);

        $path = storage_path('prolog/expert.pl');
        $path = str_replace('\\', '/', $path);

        $query = "";
        if (!empty($facts)) {
            $query = $facts . ",";
        }

        $query .= "run(D,J,C),write(D),write('|'),write(J),write('|'),write(C).";

        $cmd = "swipl -q -s \"$path\" -g \"$query\" -t halt";
        $out = shell_exec($cmd);
        Log::info($cmd);
        Log::info("SWIPL Output: " . $out);

        if (empty($out) || substr_count($out, '|') < 2) {
            Log::error("SWI-Prolog did not return the expected output. Output: " . $out);
            return response()->json(['error' => 'Failed to get analysis from expert system.', 'prolog_output' => $out], 500);
        }

        [$d,$j,$c] = explode('|',$out);
        log::info($this->parsePrologList($c));
        return response()->json([
            'decision'=>$d,
            'justification'=>$j,
            'conseils'=>$this->parsePrologList($c)
        ]);
    }

    public function change_filere(Request $request)
    {

        $niveau = $request->niveau;
        $path = storage_path('prolog/changement.pl');
        $path = str_replace('\\', '/', $path);
        $query = "assert(niveau($niveau)),run(N),write(N).";
        $cmd = "swipl -q -s \"$path\" -g \"$query\" -t halt";
        $out = shell_exec($cmd);
        Log::info($cmd);
        Log::info("SWIPL Output: " . $out);
        return response()->json($this->parsePrologList($out));
    }
}
