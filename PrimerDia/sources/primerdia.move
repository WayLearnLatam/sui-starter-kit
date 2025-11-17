module primerdia::modulo {
    use std::debug::print;
    use std::string::utf8;

    const CONSTANTE: u16 = 10;

    fun suma() {
        let conversion: u8 = CONSTANTE as u8;
        let mut numero: u8 = 10;
        numero = 15u8;
        //print(&(numero + conversion));
        //print(&(numero - conversion));
        //print(&(numero * conversion));
        //print(&(numero / conversion));
        //print(&(numero == conversion));
        print(&(numero != conversion));
        //print(&(numero > conversion));
        //print(&(numero < conversion));
        //print(&(numero >= conversion));
        //print(&(numero <= conversion));

        //if(numero > conversion) {
            //print(&(utf8(b"numero es mayor")))
        //}else if (numero < conversion) {
            //print(&(utf8(b"numero es menor")))
        //}else {
            //print(&(utf8(b"el numero es igual a al convercion")))
        //}
    }

    fun contador(x: u8) {
        let mut cuenta: u8 = 0;
        //while(x > cuenta) {
            //print(&cuenta);
            //cuenta = cuenta + 1;
        //}

        loop {
            cuenta = cuenta +1;
            if(cuenta > x) {
                break
            } else if((cuenta % 2) == 1) {
                continue
            } else {
                print(&(utf8(b"numero es par")));
            };

            print(&cuenta);
        }
    }

    #[test]
    fun practica() {
        contador(10)
    }
}