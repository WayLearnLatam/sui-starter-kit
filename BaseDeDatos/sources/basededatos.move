module basededatos::basededatos {
    use sui::vec_map::{VecMap, Self};
    use std::string::{utf8, String};



    public struct Informacion has key, store {
        id:UID,
        nombre: String,
        usuarios:VecMap<String, Usuario>
    }

    public struct Usuario has store, copy, drop {
        nombre: String,
        edad: u8,
        tipo: TipoUsuario
    }

    public enum TipoUsuario has store, copy, drop {
        Basico(Basico),
        Pro(Pro),
    }

    public struct Basico has store, copy, drop{
        mensaje: String,
    }

    public struct Pro has store, copy, drop {
        mensaje: String,
    }

    #[error]
    const ERROR_NOMBRE_EXISTE: vector<u8> = b"ERROR, EL NOMBRE DE USUARIO YA EXISTE EN LA BASE DE DATOS, INTENTA CON OTRO NUEVO";
    #[error]
    const ERROR_USUARIO_NO_EXISTE: u16 = 404;

    public fun crear_bd(nombre: String, ctx: &mut TxContext) {
        let base = Informacion {
            id: object::new(ctx),
            nombre,
            usuarios: vec_map::empty()
        };

        transfer::transfer(base, tx_context::sender(ctx));
    }

    public fun crear_usuario(informacion: &mut Informacion, nombre: String, edad: u8, tipo: u8){
        assert!(!informacion.usuarios.contains(&nombre), ERROR_NOMBRE_EXISTE);
        
        let tipo_usuario =
        if (tipo == 0) {
            TipoUsuario::Basico(Basico { mensaje: utf8(b"Usuario Basico") })
        } else {
            TipoUsuario::Pro(Pro { mensaje: utf8(b"Usuario Pro") })
        };

        let usuario = Usuario {
            nombre,
            edad,
            tipo: tipo_usuario
        };

        informacion.usuarios.insert(nombre, usuario);

    }

    public fun modificar_usuario(informacion: &mut Informacion, nombre: String, edad: u8, tipo: u8) {
        assert!(informacion.usuarios.contains(&nombre), ERROR_USUARIO_NO_EXISTE);

        let tipo_usuario =
            if (tipo == 0) {
                TipoUsuario::Basico(Basico { mensaje: utf8(b"Usuario Basico") })
            } else {
                TipoUsuario::Pro(Pro { mensaje: utf8(b"Usuario Pro") })
            };

        let info_usuario = informacion.usuarios.get_mut(&nombre);

        info_usuario.edad = edad;
        info_usuario.tipo = tipo_usuario;
    }

    public fun eliminar_usuario(informacion: &mut Informacion, nombre: String, edad: u8, tipo: u8) {
        assert!(informacion.usuarios.contains(&nombre), ERROR_USUARIO_NO_EXISTE);

        informacion.usuarios.remove(&nombre);
    }
}