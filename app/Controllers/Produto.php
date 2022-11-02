<?php
namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\ProdutoModel;

class Produto extends BaseController
{
    public $ProdutoModel;

    /**
     * Método construstutor
     */
    public function __construct()
    {
        $this->ProdutoModel = new ProdutoModel();
    }

    /**
     * Carrega view com a lista Produtos
     *
     * @return void
     */
    public function index()
    {
        $data['data'] = $this->ProdutoModel->getListaProduto();

        return view('admin/listaProduto', $data);
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
            $this->dados['data'] = $this->ProdutoModel->find($id);

            if (empty($this->dados['data'])) {
                throw new \CodeIgniter\Database\Exceptions\DatabaseException("Registro não localização na base de dados (" . $id .  ")");
            }
        } 

        return view("admin/formProduto", $this->dados);
    }

    /**
     * store
     *
     * @return void
     */
    public function store()
    {
        $post = $this->request->getPost();

        if ($this->ProdutoModel->save([
            'id'                => $post['id'],
            'descricao'         => $post['descricao'],
            'statusRegistro'    => $post['statusRegistro']
        ])) {
            return redirect()->to("/Produto")->with('msgSucess', 'Dados atualizados com sucesso.');
        } else {
            return view("admin/formProduto" , [
                'action'    => $post['action'],
                'data'      => $post,
                'errors'    => $this->ProdutoModel->errors()
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
        if ($this->ProdutoModel->delete($this->request->getPost('id'))) {
            return redirect()->to("/Produto")->with('msgSucess', "Dados excluídos com sucesso.");
        } else {
            return redirect()->to('/Produto')->with('msgError', 'Erro ao tentar excluír os dados.');
        }
    }


}