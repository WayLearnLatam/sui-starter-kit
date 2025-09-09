module base_datos_gym::base_datos_gym {
    use std::string::String;
    use sui::vec_map::{VecMap, Self};

    public struct Gym has key, store{
        id: UID,
        usuarios: VecMap<u64,Usuarios>,
    }

    public struct Usuarios {
        nombre: String,
        edad: u8,
        dni: u32,
        membresia_activa: bool,
    }
}