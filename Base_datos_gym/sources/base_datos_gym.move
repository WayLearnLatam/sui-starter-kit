module base_datos_gym::base_datos_gym {
    use std::string::String;
    use sui::vec_map::{VecMap, Self};

    #[error]
    const ID_YA_EXISTE: vector<u8> = b"El ID del usuario insertado ya existe";
    #[error]
    const ID_NO_EXISTE: vector<u8> = b"El ID del usuario insertado no existe";
    

    public struct Gym has key, store{
        id: UID,
        usuarios: VecMap<u64,Usuarios>,
    }

    public struct Usuarios has store, copy, drop {
        nombre: String,
        edad: u8,
        dni: u32,
        membresia_activa: bool,
    }

    //Esto del allow lo puse porque me pedia que tenga esto para ignorar que mandaba el ctx porque tenia que ser algo de componsable
    #[allow(lint(self_transfer))]
    public fun crear_gimnacio(ctx: &mut TxContext) {
        let usuarios = vec_map::empty();
        let gym = Gym {
            id: object::new(ctx),
            usuarios,
        };
        transfer::transfer(gym,tx_context::sender(ctx));
    }

    public fun agregar_usuario(gym: &mut Gym, id_usuarios:u64 ,nombre: String, edad:u8,dni:u32) {
        assert!(!gym.usuarios.contains(&id_usuarios),ID_YA_EXISTE);
        let usuarios = Usuarios {
            nombre,
            edad,
            dni,
            membresia_activa: true
        };
        gym.usuarios.insert(id_usuarios,usuarios);
    }

    public fun eliminar_usuario(gym: &mut Gym, id_usuarios:u64) {
        assert!(gym.usuarios.contains(&id_usuarios),ID_NO_EXISTE);
        gym.usuarios.remove(&id_usuarios);
    }

    public fun editar_usuario(gym: &mut Gym, id_usuarios:u64 ,nuevo_nombre:String,nueva_edad:u8, nuevo_dni:u32 ) {
        assert!(gym.usuarios.contains(&id_usuarios),ID_NO_EXISTE);
        let (_id, mut usuario) = gym.usuarios.remove(&id_usuarios);
        usuario.nombre = nuevo_nombre;
        usuario.edad = nueva_edad;
        usuario.dni = nuevo_dni;
        gym.usuarios.insert(id_usuarios,usuario);
    }

    public fun actualizar_membresia(gym: &mut Gym, id_usuarios:u64) {
        assert!(gym.usuarios.contains(&id_usuarios),ID_NO_EXISTE);
        let usuario = gym.usuarios.get_mut(&id_usuarios);
        usuario.membresia_activa = !usuario.membresia_activa; 
    }
}

