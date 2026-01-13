# Système Expert — Documentation des endpoints API

Ce projet expose une API REST pour l’orientation académique via un système expert Prolog. Cette documentation couvre les endpoints disponibles, les paramètres, les schémas de requêtes et les réponses.

## Base URL

- Les routes API sont préfixées par `/api`.
- Exemple: `GET /api/ues/{filiere}/{niveau}`

## Authentification

- `GET /api/user` requiert une authentification via Sanctum (`auth:sanctum`).
- Les autres endpoints sont publics.

## Endpoints

### 1) GET `/api/ues/{filiere}/{niveau}`

- Rôle: retourne la liste des UEs et leurs ECs pour une filière et un niveau.
- Paramètres de chemin:
  - `filiere`: ex. `informatique`, `physique_chimie`, `sciences_eaux_env`, `math_info`
  - `niveau`: ex. `l1`, `l2`, `l3`
- Réponse: `200 OK` avec JSON

Exemple de requête:

```bash
curl -s http://localhost:8000/api/ues/informatique/l1
```

Exemple de réponse:

```json
[
  {
    "code": "algorithmique",
    "nom": "algorithmique",
    "ecs": ["algorithme_et_programmation_1", "introducrion_au_systeme_dexploitation"]
  },
  {
    "code": "mathematique",
    "nom": "mathematique",
    "ecs": ["analyse_1", "algebre_1"]
  }
]
```

### 2) POST `/api/guidance/analyse`

- Rôle: envoie les notes par EC au système expert Prolog et retourne une décision, une justification et des conseils.
- Corps JSON attendu:

```json
{
  "ues": [
    {
      "code": "algorithmique",
      "ecs": [
        { "nom": "algorithme_et_programmation_1", "note": 14 },
        { "nom": "introducrion_au_systeme_dexploitation", "note": 12 }
      ]
    },
    {
      "code": "mathematique",
      "ecs": [
        { "nom": "analyse_1", "note": 10 },
        { "nom": "algebre_1", "note": 9 }
      ]
    }
  ]
}
```

Exemple de requête:

```bash
curl -sX POST http://localhost:8000/api/guidance/analyse \
  -H "Content-Type: application/json" \
  -d '{"ues":[{"code":"algorithmique","ecs":[{"nom":"algorithme_et_programmation_1","note":14},{"nom":"introducrion_au_systeme_dexploitation","note":12}]}]}'
```

Réponse réussie (`200 OK`):

```json
{
  "decision": "admis",
  "justification": "moyenne supérieure ou égale au seuil",
  "conseils": ["continuer sur la même lancée", "renforcer les bases en mathématiques"]
}
```


## Notes techniques

- L’analyse appelle SWI-Prolog (`swipl`) avec `storage/prolog/expert.pl`. Assurez-vous que SWI-Prolog est installé et disponible dans le PATH du système.
- Les `ecs` renvoyés par `/api/ues/...` sont des identifiants texte; pour `/api/guidance/analyse`, ils doivent être enrichis avec des paires `{nom, note}`.
