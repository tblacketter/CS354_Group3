module Connection

type state = 
    | Connected 
    | Disconnected

type connection (s:state) = {
    socket_id: int
}

val start : unit -> Tot (connection Disconnected)
let start () = 
{
    socket_id = -1
}

val connect :
    connection Disconnected -> Tot (connection Connected)

let connect c = {
    socket_id = 42
}

val send :
    c:connection Connected -> msg:string -> Tot (connection Connected)

let send c msg = c

val disconnect : 
    connection Connected -> Tot (connection Disconnected)

let disconnect c = {
    socket_id = -1
}

