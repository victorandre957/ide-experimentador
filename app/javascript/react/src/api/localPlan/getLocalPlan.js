import axios from "axios";

export function getLocalPlan({ queryKey }) {
  const id = queryKey[1];
  return axios.get(`/local_plan/${id}`);
}
