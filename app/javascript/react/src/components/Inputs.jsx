import React, { useState, useEffect } from "react";

const LocalPlanForm = ({ step, stepIndex, onRemove, onChange }) => {
  const [selectedSkill, setSelectedSkill] = useState("");
  const [formParams, setFormParams] = useState({
    skill: "",
    label: "",
    parameters: {},
  });

  useEffect(() => {
    setFormParams(step);
    setSelectedSkill(step.skill);
  }, [step]);

  const handleSkillChange = (e) => {
    const _skill = e.target.value;
    const updatedParams = { ...formParams, skill: _skill, parameters: {} };
    if(_skill === "navigation") {
      updatedParams.parameters = { room: "", waypoints: [] };
    }
    onChange(stepIndex, updatedParams);
    setSelectedSkill(_skill);
    setFormParams(updatedParams);
  };

  const handleLabelChange = (e) => {
    const { value } = e.target;
    onChange(stepIndex, { ...formParams, label: value });
    setFormParams((prevParams) => ({
      ...prevParams,
      label: value,
    }));
  };

  const handleInputChange = (name, value) => {
    onChange(stepIndex, {
      ...formParams,
      parameters: {
        ...formParams.parameters,
        [name]: value,
      },
    });
    setFormParams((prevParams) => ({
      ...prevParams,
      parameters: {
        ...prevParams.parameters,
        [name]: value,
      },
    }));
  };

  const handleWaypointChange = (index, coord, value) => {
    onChange(stepIndex, {
      ...formParams,
      parameters: {
        ...formParams.parameters,
        waypoints: formParams.parameters.waypoints.map((waypoint, i) =>
          i === index ? { ...waypoint, [coord]: value } : waypoint
        ),
      },
    });
    setFormParams((prevParams) => ({
      ...prevParams,
      parameters: {
        ...prevParams.parameters,
        waypoints: prevParams.parameters.waypoints.map((waypoint, i) =>
          i === index ? { ...waypoint, [coord]: value } : waypoint
        ),
      },
    }));
  };

  const handleAddWaypoint = () => {
    onChange(stepIndex, {
      ...formParams,
      parameters: {
        ...formParams.parameters,
        waypoints: [
          ...(formParams.parameters.waypoints || []),
          { x: "", y: "", z: "" },
        ],
      },
    });
    setFormParams((prevParams) => ({
      ...prevParams,
      parameters: {
        ...prevParams.parameters,
        waypoints: [
          ...(prevParams.parameters.waypoints || []),
          { x: "", y: "", z: "" },
        ],
      },
    }));
  };

  const handleRemoveWaypoint = () => {
    onChange(stepIndex, {
      ...formParams,
      parameters: {
        ...formParams.parameters,
        waypoints: formParams.parameters.waypoints.slice(0, -1),
      },
    });
    setFormParams((prevParams) => {
      const waypoints = prevParams.parameters.waypoints || [];
      waypoints.pop(); // Remove the last waypoint
      return {
        ...prevParams,
        parameters: { ...prevParams.parameters, waypoints },
      };
    });
  };

  const handleRemove = () => {
    onRemove(stepIndex);
  };

  const renderFormInputs = () => {
    return (
      <div>
        <label htmlFor="labelInput">Label:</label>
        <input
          id="labelInput"
          type="text"
          placeholder="Label"
          value={formParams.label || ""}
          onChange={handleLabelChange}
        />
        <label htmlFor="skillSelect">Select Skill:</label>
        <select
          id="skillSelect"
          onChange={handleSkillChange}
          value={formParams.skill || ""}
        >
          <option value="">Select a skill</option>
          <option value="navigation">Navigation</option>
          <option value="operate_drawer">Operate Drawer</option>
          <option value="approach_person">Approach Person</option>
          <option value="authenticate_person">Authenticate Person</option>
        </select>

        <button onClick={handleRemove}>Deletar etapa</button>

        {renderFormInputsForSkill()}
        <pre>{JSON.stringify(formParams, null, 2)}</pre>
      </div>
    );
  };

  const renderFormInputsForSkill = () => {
    if (selectedSkill === "navigation") {
      return (
        <div>
          <input
            type="text"
            placeholder="Room"
            onChange={(e) => handleInputChange("room", e.target.value)}
            value={formParams.parameters.room || ""}
          />
          <button onClick={handleAddWaypoint}>Add Waypoint</button>
          <button onClick={handleRemoveWaypoint}>Remove Last Waypoint</button>
          {renderWaypointInputs()}
        </div>
      );
    } else if (
      selectedSkill === "operate_drawer" ||
      selectedSkill === "approach_person" ||
      selectedSkill === "authenticate_person"
    ) {
      const key = selectedSkill === "operate_drawer" ? "action" : "topic";
      return (
        <input
          type="text"
          value={formParams.parameters[key] || ""}
          placeholder={selectedSkill === "operate_drawer" ? "Action" : "Topic"}
          onChange={(e) => handleInputChange(key, e.target.value)}
        />
      );
    }

    return null;
  };

  const renderWaypointInputs = () => {
    if (selectedSkill === "navigation" && formParams.parameters.waypoints) {
      return formParams.parameters.waypoints.map((waypoint, index) => (
        <div key={index}>
          <input
            type="number"
            value={waypoint.x || ""}
            placeholder="x"
            onChange={(e) => handleWaypointChange(index, "x", e.target.value)}
          />
          <input
            type="number"
            value={waypoint.y || ""}
            placeholder="y"
            onChange={(e) => handleWaypointChange(index, "y", e.target.value)}
          />
          <input
            type="number"
            value={waypoint.z || ""}
            placeholder="z"
            onChange={(e) => handleWaypointChange(index, "z", e.target.value)}
          />
        </div>
      ));
    }

    return null;
  };

  return <div>{renderFormInputs()}</div>;
};

export default LocalPlanForm;
