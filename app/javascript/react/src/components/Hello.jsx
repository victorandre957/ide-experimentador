import React, {useState} from 'react'
                                                        
const Hello = (props) => {                                   
  let [count, setCount] = useState(0)
  return (
    <div>
      <h1>Counter {props.name}: {count}</h1>
      <button onClick={()=>{
        setCount(count+1)
        console.log(props)
      }}> Add </button>
    </div>
  )                   
}                                                       
                                        
export default Hello
