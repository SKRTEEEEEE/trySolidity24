// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2;

contract TaskList {

    //Rellenar mapping, array, utilizar enum
    enum difficulty {LOW, MEDIUM, HIGH}

    struct Task {
        uint8 id;
        string desc;
        difficulty level;
    }

    uint8 numTask;
    string [] descriptions; 
    mapping (uint8=> Task) tasks;//Clave id de cada tarea vinculada a cada tarea, se guarda en tasks

    //indexed, *facilita la busqueda desde otros lenguajes
    event AddTask(uint8 indexed id, string text, address indexed  sender);
    constructor(){
        numTask = 0;//no es necesario pero bien
    }

    //Funcion para añadir tareas a nuestra lista/mapping
    function addTask(string memory _text, difficulty _level) public returns(bool success) {
        //introducimos la tarea en el mapping tasks
        tasks[numTask] = Task(numTask, _text, _level); //tenemos que poner en el orden que esta en Task
        
        emit AddTask(numTask, _text, msg.sender);
        
        descriptions.push(_text);
        numTask++;//sumamos uno para incrementar el indicador
        
        return true;//devolvemos true para saber que esta ok
    }
    //Funcion que devuelve la tarea segun el ID

    function getTaskById(uint8 _id) public view returns (Task memory _task){
        return tasks[_id];
    }

    //Funcion que devuelve todas las tareas

    function getAllTasks() public view returns (string [] memory _allTasks){
        return descriptions;
    }
}