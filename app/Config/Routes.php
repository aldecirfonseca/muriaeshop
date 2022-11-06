<?php

namespace Config;

// Create a new instance of our RouteCollection class.
$routes = Services::routes();

// Load the system's routing file first, so that the app and ENVIRONMENT
// can override as needed.
if (is_file(SYSTEMPATH . 'Config/Routes.php')) {
    require SYSTEMPATH . 'Config/Routes.php';
}

/*
 * --------------------------------------------------------------------
 * Router Setup
 * --------------------------------------------------------------------
 */
$routes->setDefaultNamespace('App\Controllers');
$routes->setDefaultController('Home');
$routes->setDefaultMethod('index');
$routes->setTranslateURIDashes(false);
$routes->set404Override();
// The Auto Routing (Legacy) is very dangerous. It is easy to create vulnerable apps
// where controller filters or CSRF protection are bypassed.
// If you don't want to define all routes, please use the Auto Routing (Improved).
// Set `$autoRoutesImproved` to true in `app/Config/Feature.php` and set the following to true.
$routes->setAutoRoute(true);

/*
 * --------------------------------------------------------------------
 * Route Definitions
 * --------------------------------------------------------------------
 */

// We get a performance increase by specifying the default
// route since we don't have to scan directories.

// página principal (controller home)

$routes->get('/', 'Home::index');
$routes->get('home', 'Home::index');
$routes->get('sobrenos', 'Home::sobrenos');
$routes->get('contato', 'Home::contato');
$routes->post('contatoEnviaEmail', 'Home::contatoEnviaEmail');
$routes->get('login', 'Home::login');
$routes->get('criarNovaConta', 'Home::criarNovaConta');
$routes->get('carrinhoCompras', 'Home::carrinhoCompras');
$routes->get('carrinhoPagamento', 'Home::carrinhoPagamento');
$routes->get('carrinhoConfirmacao', 'Home::carrinhoConfirmacao');
$routes->get('produtodetalhe/(:num)', 'Home::produtoDetalhe/$1');

// Login
$routes->group('Login', function ($routes) {
    $routes->post('signIn', 'Login::signIn');
    $routes->get('signOut', 'Login::signOut');
});

// sistema
$routes->group('Sistema', function ($routes) {
    $routes->get('home', 'Sistema::home');
});

// Crud UF
$routes->group('Uf', function ($routes) {
    $routes->get('/', 'Uf::index');
    $routes->get('lista', 'Uf::index');
    $routes->get('form/(:segment)/(:num)', 'Uf::form/$1/$2');
    $routes->post('store', 'Uf::store');
    $routes->post('delete', 'Uf::delete');
});

// Crud Departamento
$routes->group('Departamento', function ($routes) {
    $routes->get('/', 'Departamento::index');
    $routes->get('lista', 'Departamento::index');
    $routes->get('form/(:segment)/(:num)', 'Departamento::form/$1/$2');
    $routes->post('store', 'Departamento::store');
    $routes->post('delete', 'Departamento::delete');
});

// Crud Produto
$routes->group('Produto', function ($routes) {
    $routes->get('/', 'Produto::index');
    $routes->get('lista', 'Produto::index');
    $routes->get('form/(:segment)/(:num)', 'Produto::form/$1/$2');
    $routes->post('store', 'Produto::store');
    $routes->post('delete', 'Produto::delete');
    $routes->get('excluirImagem/(:num)/(:segment)/(:segment)', 'Produto::excluirImagem/$1/$2/$3');

});

/*
 * --------------------------------------------------------------------
 * Additional Routing
 * --------------------------------------------------------------------
 *
 * There will often be times that you need additional routing and you
 * need it to be able to override any defaults in this file. Environment
 * based routes is one such time. require() additional route files here
 * to make that happen.
 *
 * You will have access to the $routes object within that file without
 * needing to reload it.
 */
if (is_file(APPPATH . 'Config/' . ENVIRONMENT . '/Routes.php')) {
    require APPPATH . 'Config/' . ENVIRONMENT . '/Routes.php';
}
