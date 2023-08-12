import { Task } from "../models/task.js"

export const newTask = async(req,res,next)=>{
    const {
        temperature,
        dissolvedOxygen,
        pH,
        ammonia,nitrate} = req.body;
   let tasks = await Task.create ({
        
        temperature,
        dissolvedOxygen,
        pH,
        ammonia,nitrate,

        user:req.user,
    });
    res.status(201).json({
        success:true,
        message:"value given",
    })

};

export const displaytask = async(req, res,next) =>{
    const userid = req.user._id;
    const tasks = await Task.find({user:userid});  

    res.status(200).json({
        success:true,
        tasks,
    })
}