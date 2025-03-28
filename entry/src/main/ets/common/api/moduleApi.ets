
import { axiosInstance } from '../utils/myHttps';
import { AxiosResponse } from '@ohos/axios';


// 引入 userType.ets 中的 UserInfoResponse 类型
import { newSwiperItemType } from '../type/moduleType';



//查询导航页面模块详情
export function queryDatas(pageId:string,modules:string,productId:string): Promise<AxiosResponse<newSwiperItemType>> {
  return axiosInstance({
    url: '/api/xy/toc/v2/queryDatas',
    method: 'GET',
    params: {
      pageId,
      modules,
      productId
    }
  });
}