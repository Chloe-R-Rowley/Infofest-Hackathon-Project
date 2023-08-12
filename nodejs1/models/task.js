import mongoose from "mongoose";
const UserSchema = mongoose.Schema({
    // createdat: {
    //     type: String,
    //     required: true
    //   },
     
      temperature: {
        type: Number,
        required: true
      },
      dissolvedOxygen: {
        type: Number,
        required: true
      },
      user:{
        type:mongoose.Schema.Types.ObjectId,
        ref:"User"
      },
      pH: {
        type: Number,
        required: true
      },
      ammonia: {
        type: Number,
        required: true
      },
      nitrate: {
        type: Number,
        required: true
      }

});
export const Task = mongoose.model("Task" , UserSchema);