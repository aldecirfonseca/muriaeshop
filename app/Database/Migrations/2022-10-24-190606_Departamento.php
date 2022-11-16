<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class Departamento extends Migration
{
    public function up()
    {
        $this->forge->addField([
            'id'    => [
                'type'              => 'INT',
                'constraint'        => 11,
                'auto_increment'    => true,
            ],
            'descricao' => [
                'type'              => 'VARCHAR',
                'constraint'        => 50,
            ],
            'statusRegistro'    => [
                'type'              => 'INT',
                'constraint'        => 11,
                'comment'           => '1=Ativo; 2=Inativo',
                'default'           => '1',
            ],
            'imagem' => [
                'type'              => 'VARCHAR',
                'constraint'        => 150,
                'null'              => true,
            ],
            'created_at' => [
                'type'              => 'DATETIME',
                'null'              => true,
            ],
            'updated_at' => [
                'type'              => 'DATETIME',
                'null'              => true,
            ],
            'deleted_at' => [
                'type'              => 'DATETIME',
                'null'              => true,
            ],
        ]);

        $this->forge->addKey('id', true);
        $this->forge->createTable('departamento', false, ['ENGINE' => 'InnoDB']);
    }

    public function down()
    {
        $this->forge->dropTable('departamento');
    }
}
