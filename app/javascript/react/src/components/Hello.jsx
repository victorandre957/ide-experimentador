import React, {useEffect, useState} from 'react'
                                                        
const Hello = (props) => {                                   
  
  let [count, setCount] = useState(2)
  let [req, setReq] = useState("") 

  useEffect(() => {
    fetch("/hello/worldGet").then(async res=>{
      const parse = await res.text()
      console.log(parse)
      return parse
    }).then(res=>setReq(res))
  }, [])
  
  return (
    <div>
      <h1>Counter prop:{props.name}: {count}</h1>
      <h2>{req}</h2>
      <button onClick={()=>{
        setCount(count+1)
      }}> Add </button>
    </div>
  )                   
}                                                       
                                        
export default Hello