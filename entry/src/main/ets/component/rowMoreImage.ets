//横板多图

import {newSwiperItemType,Result,liveList} from '../common/type/moduleType';
import {queryDatas} from '../common/api/moduleApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import { hilog } from '@kit.PerformanceAnalysisKit';
import uinfo from '../common/utils/getUserInfo';
import {MARGIN_TOP_Modules,Font_GRAY}from '../common/style/moduleVariables'

@Component
export default  struct rowMoreImage {
  @Prop freshPageNum:number
  @Prop modules:string
  @Prop pageId:string
  @State moduleData:Result={}
  @State currentIndex:number=0
  @State liveData:liveList[]=[]

  aboutToAppear(): void {
    this.getBigImgListData()
  }


  // 获取模块详情
  getBigImgListData(){
    let modules = `${this.modules}_${this.freshPageNum}_10`
    queryDatas(this.pageId,modules,uinfo.getProductId())
      .then((response: AxiosResponse<newSwiperItemType>) => {
        const data = response.data;
        if (data&&data.code===0) {
          this.moduleData = data.data[this.modules].docs.results[0]
          this.liveData = this.moduleData.lives||[]
          hilog.info(0x0000, '请求成功', '横板多图moduleData : %{public}s', JSON.stringify(this.liveData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', '横板多图moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        }
      })
      .catch((err: AxiosError<newSwiperItemType>) => {
        console.log('请求出错:', err.message);
      });
  }
  build() {
    Column(){
      Text('横板多图')
    }
    .onClick(() => {
      console.log('点击了大图列表',JSON.stringify(this.moduleData))
    })
    .padding({left:10,right:10})
    .width('100%')
    .backgroundColor('#fff')
    .margin({top:MARGIN_TOP_Modules})
  }

}