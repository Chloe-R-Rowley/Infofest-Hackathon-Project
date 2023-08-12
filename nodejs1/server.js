import { app } from "./app.js";
import { dbconnect} from "./data/database.js";


dbconnect(); 


console.log(process.env.PORT)
app.listen(process.env.PORT, ()=>{
    console.log(`server is listening on port number ${process.env.PORT} and is in ${process.env.NODE_ENV} mode `)
})

