import express from "express";
import { displaytask, newTask } from "../controllers/task.js";
import { isAuthenticated } from "../middlewares/auth.js";
const taskrouter = express.Router();


taskrouter.post("/create",isAuthenticated, newTask)

taskrouter.get("/display",isAuthenticated, displaytask)


export default taskrouter;