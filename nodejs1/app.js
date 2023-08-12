import express  from "express";

import router from "./routes/user.js";
import taskrouter from "./routes/task.js";
import { config } from "dotenv";
import cookieParser from "cookie-parser";
import cors from "cors";


export const app = express()  ;


config({
    path:"./data/config.env",
});
//middleware 
app.use(express.json());
app.use(cookieParser());
app.use(cors())
app.use("/api/v1/users", router);
app.use("/api/v1/task", taskrouter);




