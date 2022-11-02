<?php

namespace App\Models;

use CodeIgniter\Model;

class UfModel extends BaseModel
{
    protected $table = 'uf';
    protected $primarykey = 'id';

    protected $allowedFields = ['sigla', 'descricao', 'regiao', 'codIBGE'];

    protected $useTimestamps  = true;
    //protected $useSoftDeletes = true;

    protected $validationRules = [
        "sigla"  => [
            "label" => 'UF',
            "rules" => 'required'
        ],
        "descricao"  => [
            "label" => 'Nome da UF',
            "rules" => 'required|min_length[3]|max_length[60]'
        ],
        "regiao"  => [
            "label" => 'Região',
            "rules" => 'required|integer'
        ],
        "codIBGE"  => [
            "label" => 'Código do IBGE da UF',
            "rules" => 'required|min_length[2]|max_length[2]'
        ]
    ];
}