<?php
namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\DepartamentoModel;

class Departamento extends BaseController
{
    public $DepartamentoModel;

    /**
     * Método construstutor
     */
    public function __construct()
    {
        $this->DepartamentoModel = new DepartamentoModel();
    }

    /**
     * Carrega view com a lista departamentos
     *
     * @return void
     */
    public function index()
    {
        $data['data'] = $this->DepartamentoModel->getLista([], "descricao");

        return view('admin/listaDepartamento', $data);
    }

    /**
     * form
     *
     * @param mixed $action 
     * @param mixed $id 
     * @return void
     */
    public function form($action = null, $id = null)
    {
        $this->dados['action'] = $action;
        $this->dados['data']   = null;

        if ($action != 'new') {
            $this->dados['data'] = $this->DepartamentoModel->find($id);

            if (empty($this->dados['data'])) {
                throw new \CodeIgniter\Database\Exceptions\DatabaseException("Registro não localização na base de dados (" . $id .  ")");
            }
        } 

        return view("admin/formDepartamento", $this->dados);
    }

    /**
     * store
     *
     * @return void
     */
    public function store()
    {
        $post = $this->request->getPost();

        if ($this->DepartamentoModel->save([
            'id'                => $post['id'],
            'descricao'         => $post['descricao'],
            'statusRegistro'    => $post['statusRegistro']
        ])) {
            session()->remove('aMenuDepartamento');
            return redirect()->to("/Departamento")
                ->with('msgSucess', 'Dados atualizados com sucesso.');
        } else {
            return view("admin/formDepartamento" , [
                'action'    => $post['action'],
                'data'      => $post,
                'errors'    => $this->DepartamentoModel->errors()
            ]);
        }
    }

    /**
     * delete
     *
     * @return void
     */
    public function delete()
    {
        if ($this->DepartamentoModel->delete($this->request->getPost('id'))) {
            session()->remove('aMenuDepartamento');
            return redirect()->to("/Departamento")->with('msgSucess', "Dados excluídos com sucesso.");
        } else {
            return redirect()->to('/Departamento')->with('msgError', 'Erro ao tentar excluír os dados.');
        }
    }


}