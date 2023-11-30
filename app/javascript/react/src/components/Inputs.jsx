import React from 'react';

const Inputs = ({ params, index, onChange, onRemove }) => {
 const handleChange = (e) => {
    onChange(index, e.target.name, e.target.value);
 };

 const handleRemove = () => {
    onRemove(index);
 };

 return (
    <div>
      <label>
        Skill:
        <input type="text" name="skill" value={params.skill} onChange={handleChange} />
      </label>
      <label>
        Parameters:
        <input type="text" name="parameters" value={params.parameters} onChange={handleChange} />
      </label>
      <label>
        Goal:
        <input type="text" name="goal" value={params.goal} onChange={handleChange} />
      </label>
      <button onClick={handleRemove}>Remove</button>
    </div>
 );
};

export default Inputs;