# Entrega Lucia Mottillo - 340597
#!/bin/bash
title(){
    rojo='\033[0;32m'
    sinColor='\033[0m'
    echo -e "${rojo}Menu${sinColor}"
}

menu(){
    echo "1. Listar los usuarios registrados"
    echo "2. Dar de alta un usuario."
    echo "3. Configurar letra de inicio."
    echo "4. Configurar letra de fin."
    echo "5. Configurar letra contenida"
    echo "6. Consultar diccionario"
    echo "7. Ingresar vocal"
    echo "8. Listar las palabras con la vocal"
    echo "9. Algoritmo 1"
    echo "10. Algoritmo 2"
    echo "11. Salir."
    echo -e "${rojo}Ingrese su opcion${sinColor}"
}

listarUsuarios(){
    i=1
        while IFS= read -r line; do
            if [[ $((i%2)) -eq 1 ]]; then
                echo "$line"
            fi
            ((i++))
        done < documento.txt
    continuarRosado
}

agregarUsuario(){
    echo "Introduzca nombre de usuario" 
    read usuario
    while  awk 'NR % 2 == 1' documento.txt | grep -qw $usuario ; do
        echo "Ya existe, pruebe de nuevo"
        read usuario
    done
    echo "$usuario" >> documento.txt
    echo "Introduzca la contraseña"
    read contra
    echo "$contra" >> documento.txt
    continuarRosado
}

letraInicio(){
    echo "Primera letra"
    read primeraLetra
    while [[ "$primeraLetra" =~ ^[0-9]+$ ]] ; do
        echo $primeraLetra " es un número, ingrese una letra"
        read primeraLetra
    done
    continuarRosado
}

letraFinal(){
    echo "Ultima letra"
    read ultimaLetra
    while [[ "$ultimaLetra" =~ ^[0-9]+$ ]] ; do
        echo $ultimaLetra " es un número, ingrese una letra"
        read ultimaLetra
    done
    continuarRosado
}

letraContenida(){
    echo "Letra contenida"
    read letraContenida
    while [[ $letraContenida =~ ^[0-9]+$ ]] ; do
        echo $letraContenida " es un número, ingrese una letra"
        read letraContenida
    done
    continuarRosado
}

consultarDiccionario(){
    if [[ -z "$primeraLetra" && -z "$letraContenida" && -z "$ultimaLetra" ]]; then
        echo "La primera letra, la contenida o la ultima esta vacia"
    else 
        touch new.txt
        palabras_validas=$(grep "^$primeraLetra.*$letraContenida.*$ultimaLetra$" diccionario.txt)
        if [[ -z "$palabras_validas" ]] ; then
            echo "No hay palabras validas"
            echo "La cantidad total de palabras son: 0"
            echo "La cantidad de palabras validas es: 0 palabras" >> new.txt
            echo "El porcentaje de palabras validas sobre el total es: 0%" >> new.txt
            
        else
            echo "Las palabras que cumplen la condicion son: "
            echo "$palabras_validas"
            echo "$palabras_validas" >> palabras.txt
            cantidad_palabras=$(wc -l < palabras.txt)
            echo "La cantidad total de palabras son: $cantidad_palabras"
            echo "La cantidad de palabras validas es: $cantidad_palabras palabras" >> new.txt
            porcentaje=$(echo "scale=2; ($cantidad_palabras * 100) / $cantidad_total" | bc)
            echo "El porcentaje de palabras validas sobre el total es: $porcentaje%" >> new.txt
            rm -f palabras.txt
        fi
        fecha=$(date +"%d-%m-%Y")
        echo "La fecha es: $fecha" >> new.txt
        cantidad_total=$(wc -l < diccionario.txt)
        echo "La cantidad total de palabras en el diccionario es: $cantidad_total"
        echo "La cantidad total de palabra del diccionario es: $cantidad_total palabras" >> new.txt
        usuario=$username
        echo "El usuario es: $usuario" >> new.txt
    fi
    continuarRosado
}

ingresarVocal(){
    vocal_valida=false
    while ! $vocal_valida; do
        echo "Ingrese vocal (a, e, i, o, u)"
        read vocal
        if [[ $vocal == "a" || $vocal == "e" || $vocal == "i" || $vocal == "o" || $vocal == "u" ]]; then
            vocal_valida=true
        else
            echo "No es una vocal valida. Ingrese una vocal. (a, e, i, o, u)"
        fi
    done
    continuarRosado
}

listarPalabras(){
    vocales="aeiou"
    echo "Las palabras que contienen $vocal son: "
    grep "$vocal" diccionario.txt
    continuarRosado
}

algoritmoUno(){
    echo "Ingrese cantidad de datos a ingresar" 
    read tope
    while [[ ! $tope =~ ^[0-9]+$ ]] ; do
        echo "$tope es una letra, ingrese un número"
        read tope
    done
    while [ "$tope" -le "0" ]; do
        echo "Ingrese un valor mayor a cero" 
        read tope
    done
    echo "Ingrese numero entero" 
    read numero
    suma=$numero
    max=$numero
    min=$numero
    for((i=2; i<= $tope; i++)); do 
        echo "Ingrese numero entero" 
        read numero
        suma=$((suma + numero))
        if [ "$numero" -lt "$min" ]; then
            min=$numero
        fi
        if [ "$numero" -gt "$max" ]; then
            max=$numero
        fi
    done
    promedio=$((suma / tope))
    echo "El promedio es $promedio"
    echo "El menor dato ingresado es $min"
    echo "El mayor dato ingresado es $max"
    continuarRosado
} 

algortimoDos(){
    echo "Ingrese una palabra"
    read palabra
    largo=${#palabra}
    palabraAlReves=""
    for ((i=largo-1;i>=0;i--)); do
        palabraAlReves+=${palabra:i:1}
    done
    if [ "$palabra" = "$palabraAlReves" ] ; then
        echo "$palabra es capicua"
    else
        echo "$palabra no es capicua"
    fi
    continuarRosado
}

salir(){
    exit
}
#color rosado
continuarRosado(){
    texto="Presione enter para continuar"
    rosado='\033[1;35m' 
    sinColor='\033[0m' 
    echo -e "${rosado}$texto${sinColor}"
    read -r
}
#bienvenida y case
azul='\033[1;34m'
sinColor='\033[0m'  
echo -e "${azul}Ingrese nombre de usuario${sinColor}"
read username
echo -e "${azul}Ingrese la contrasena${sinColor}"
read password

if grep -q "^$username" documento.txt && grep -q "^$password" documento.txt ; then
    while true; do
        title
        menu
        read opcion
        case $opcion in
            1) listarUsuarios;;
            2) agregarUsuario;;
            3) letraInicio;;
            4) letraFinal;;
            5) letraContenida;;
            6) consultarDiccionario;;
            7) ingresarVocal;;
            8) listarPalabras;;
            9) algoritmoUno;;
            10) algortimoDos;;
            11) salir;;
            *) echo "Vuelva a intentar";;
        esac
    done
else 
    echo "Usuario o contrasena incorrectos."
fi

