### EXPLICACION DE COMO SE GUARDAN LOS ARCHIVOS DE TEXTO (COMO SE VEN LOS ARCHIVOS GUARDADOS CUANDO SE LOS ABRE POR EDITOR)

Siempre se guarda un resource que tiene una cabecera que define el recurso, ya sea no-tipado (en cuyo caso la cabecera principal
dira [gd_resource type="Resource" load_steps=2 format=3]) o tipado (en cuyo caso tendra un argumento extra en la 
cabecera principal [gd_resource type="Resource" script_class="TestUdObj" load_steps=2 format=3] que dice la script_class

Pero en la siguiente linea (en el listado de definiciones externas) tendra el path del script con el que fue creado el recurso
[ext_resource type="Script" path="res://data/test_ib_obj/model/test_ud_ob.gd" id="1_fxha0"] al que le asigna un id para
que abajo lo que sea creado con ese script pueda referenciarlo

 Y el recurso principal se define de la siguiente forma
	[resource]
	script = ExtResource("1_fxha0")
	metadata/_custom_type_script = "uid://bhavemoo7u4ga"
por lo que podemos ver que es un objeto que se tiene que crear con la clase definida en el archivo definido en ese path.

Entonces el rescurso al cargar de disco se crea con un modelo basado en en un script y las lineas siguientes definen los
cambios en el recurso. 

Si es un recurso cargado por editor, tendra la referencia en _cutom_type_script que esta asignada
a recurso (archivo en carpeta res://) en su definicion si lo abrimos asimismo con un editor de texto. 

###QUE PASA CUANDO SE GUARDAN RECURSOS CARGADOS POR LOAD() O CREADOS CON NEW() SIN USAR @EXPORT EN LAS VARIABLES INTERNAS (PROPIEDADES DE DICHO RECURSO)

1. Si la variable se crea con .new(), asi se haga duplicate() ni con true, no guarda las variables internas ni
aun sean int o string solo referencia al script con el que se crea el objecto
2. Si se crea con load() tampoco. Pero aparte del script guarda la referencia al recurso que se cargo 
en una referencia llamada metadata/_custom_type_script = "uid://bhavemoo7u4ga".(claro
tuvo que hacer load() a una direcion de un recurso creado por editor y no el script, con el script da error,
eso solo sirve para adjuntar el script a un nodo o para crear un objeto con este_script.new()
3. Si el recurso es cargado a memoria desde dico con load o creando con new, y no se borra dicho recurso, si lo 
volvemos a cargar si mantendra los cambios (debido a un tipo de optimizacion de memoria de godot). Siempre y cuando
sea el mismo recurso (no uno en res y otro en user)
4. Si le ponemos la anotacion @export en la variable a guardarse (la referencia al recurso) no hace ningun cambio
ya que ese recurso definitivamente se va a guardar. Y la anotacion sirve para definir cambios en un archivo.tres
despues de la referencia con la cual se creo un recurso

###QUE PASA CUANDO TENEMOS PROPIEDADES SIMPLES EN EL RECURSO Y SE GUARDA

Ahora si ponemos una de las variables del recurso con la anotacion @export o @export_storage al guardar si se guardaran
los cambios. Y (aun no hayamos cambiado) dentro del resource en texto podemos ver la variable 

se vera de la siguiente forma
	[resource]
	script = ExtResource("1_fxha0")
	simple_var = "Hola Mundo"

### QUE PASA CON ARRAYS Y DICTIONARIES

Exactamente lo mismo

### AHORA CON OBJETOS INTERNOS

1. Cuando cambiamos de objeto interno (todo el objeto) y en el objeto externo no ponemos la anotacion @export, no se cambia
y cuando si ponemos la anotacion si se cambioa, tal como esperado es igual a los otros. 

Esto pasa asi carguemos con load() o creemos con new()

Asi podemos ver en el codigo que tambien esta la referencia al objeto interno en la lista de paths y que en la variable
(que en este caso llamamos siple_object) tiene la referencia a ese ext_resource. 

No tiene directamente la referencia al script con el que se crea ese objeto interno (debe tomarlo de la definicion del .tres). 

Tampoco tiene la definicion de un subrecurso si es cargado el subrecurso de un archivo con load()

	[gd_resource type="Resource" script_class="TestUdObj" load_steps=3 format=3]

	[ext_resource type="Script" path="res://data/test_ib_obj/model/test_ud_ob.gd" id="1_a07qq"]
	[ext_resource type="Resource" path="res://data/internal_test_ud_obj/data/new_internal_test_ud_obj_1.tres" id="2_jqkpe"]

	[resource]
	script = ExtResource("1_a07qq")
	simple_string = "Hola Mundo"
	simple_int = 5
	simple_array = ["hola", "mundo"]
	simple_dictionary = {
	"mundo": "hola"
	}
	simple_object = ExtResource("2_jqkpe")
	metadata/_custom_type_script = "uid://bhavemoo7u4ga"

Si el recurso es creado con .new() si tiene subrecurso, pues al no tener un archivo donde haya la definicion de la clase con la 
que se define ni los valores, necesita crear un subrecurso y referenciar al script como se puede ver a continuacion

	[gd_resource type="Resource" script_class="TestUdObj" load_steps=4 format=3]

	[ext_resource type="Script" path="res://data/test_ib_obj/model/test_ud_ob.gd" id="1_a07qq"]
	[ext_resource type="Script" path="res://data/internal_test_ud_obj/model/internal_test_ud_obj.gd" id="2_jqkpe"]

	[sub_resource type="Resource" id="Resource_xu0k6"]
	script = ExtResource("2_jqkpe")
	name = "createdObj1"

	[resource]
	script = ExtResource("1_a07qq")
	simple_string = "Hola Mundo"
	simple_int = 5
	simple_array = ["hola", "mundo"]
	simple_dictionary = {
	"mundo": "hola"
	}
	simple_object = SubResource("Resource_xu0k6")
	metadata/_custom_type_script = "uid://bhavemoo7u4ga"


## NOTA: Podemos ver entonce que Aun con una una variable exportada en el caso de load() no crea un subrecurso y por tanto no se puede
cambiar los valores de las variables internas (mas claro, no se guardaran). Con el .new() obviamente si se guardan las variables exportadas
porque ya creo un subrecurso
