import jwt from "jsonwebtoken";


export const sendcookie =(user, res, message,statusCode=200) =>{
     const token = jwt.sign({_id:user._id}, process.env.JWT_SECRET);

    res.status(201).cookie("token" ,token,{
        httpOnly:true,
        maxAge: 15*60*1000,
        
            origin:[process.env.FRONTEND_URL],
            methods:["GET", "PUT", "POST","DELETE"],
            credentials:true,
            sameSite:process.env.NODE_ENV==="Development" ?"lax":"none",
            secure:process.env.NODE_ENV==="Development" ?false: true,
    
    }).json({
        success:true,
        message,
    })
}
