// import axios from "axios";
import axios from '../config/axios'

export const getUser = async (): Promise<any[]> => {
    try {
        const res = await axios.get('/user');
        console.log(res);
        return res.data;
    } catch (err) {
        console.log(err);
        return [];
    }
};