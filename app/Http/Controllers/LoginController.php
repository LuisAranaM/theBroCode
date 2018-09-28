<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Entity\Usuario as Usuario;

class LoginController extends Controller {

    /*public function index() {
       return view('login');
    }

    function logout(Request $request){
        return redirect()->route('login.index');
    }*/

    public function index() {
        if(\Auth::check()){
            return redirect()->route(Usuario::redirectRol(Auth::user()->ROL)); 
        }
        return view('login');
    }

    public function attempt(Request $request) {
    	//dd("HOLA");
        $usuario = $request->get('usuario', null);
        $pass = $request->get('pass', null);

        if (!Auth::attempt(['USUARIO' => $usuario, 'password' => $pass],TRUE)) {
            flash('Usuario o Contraseña errado')->error();
            return redirect()->route('login.index');
        }        
        return redirect()->route(Usuario::redirectRol(Auth::user()->ID_ROL));
    }

    protected function register($usuario) {
        \App\Model\Usuario::create([
            'NOMBRES' => 'UsuarioPrueba',
            'ID_ROL' => 1,
            'USUARIO' => $usuario,
            'PASS' => Hash::make($usuario),
        ]);
    }

    public function getNetworkUser() {
        $headers = apache_request_headers();
        if (!isset($headers['Authorization'])) {
            header('HTTP/1.1 401 Unauthorized');
            header('WWW-Authenticate: NTLM');
            exit;
        }
        $auth = $headers['Authorization'];
        if (substr($auth, 0, 5) == 'NTLM ') {
            $msg = base64_decode(substr($auth, 5));
            if (substr($msg, 0, 8) != "NTLMSSP\x00")
                die('error header not recognised');
            if ($msg[8] == "\x01") {
                $msg2 = "NTLMSSP\x00\x02\x00\x00\x00" .
                        "\x00\x00\x00\x00" . // target name len/alloc
                        "\x00\x00\x00\x00" . // target name offset
                        "\x01\x02\x81\x00" . // flags
                        "\x00\x00\x00\x00\x00\x00\x00\x00" . // challenge
                        "\x00\x00\x00\x00\x00\x00\x00\x00" . // context
                        "\x00\x00\x00\x00\x00\x00\x00\x00"; // target info len/alloc/offset
                header('HTTP/1.1 401 Unauthorized');
                header('WWW-Authenticate: NTLM ' . trim(base64_encode($msg2)));
                exit;
            } else if ($msg[8] == "\x03") {
                $user = $this->getstr($msg, 36);
                $domain = $this->getstr($msg, 28);
                $workstation = $this->getstr($msg, 44);
                return strtoupper($user);
            }
        }
    }

    function getstr($msg, $start, $unicode = true) {
        $len = (ord($msg[$start + 1]) * 256) + ord($msg[$start]);
        $off = (ord($msg[$start + 5]) * 256) + ord($msg[$start + 4]);
        if ($unicode)
            return str_replace("\0", '', substr($msg, $off, $len));
        else
            return substr($msg, $off, $len);
    }
    
    function logout(Request $request){
        Auth::logout();
        return redirect()->route('login.index');
    }

}
