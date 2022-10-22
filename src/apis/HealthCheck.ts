import axios from '@/utils/axios';

export const getServerVersion = async (): Promise<string> => {
    try {
        const res = await axios.get('/health-check');
        console.log(res);
        return res.data;
    } catch (err) {
        console.log(err);
        return '';
    }
};