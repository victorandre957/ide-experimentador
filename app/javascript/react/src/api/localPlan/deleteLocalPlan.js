import axios from "axios";

export const deleteLocalPlan = (id) => axios.delete(`local_plan/${id}`);
