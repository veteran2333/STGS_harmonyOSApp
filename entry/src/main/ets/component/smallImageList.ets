//小图列表

import {newSwiperItemType,Result,liveList} from '../common/type/moduleType';
import {queryDatas} from '../common/api/moduleApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import { hilog } from '@kit.PerformanceAnalysisKit';
import uinfo from '../common/utils/getUserInfo';
import {MARGIN_TOP_Modules,Font_GRAY}from '../common/style/moduleVariables'

@Component
export default  struct smallImageList {
  @Prop freshPageNum:number
  @Prop modules:string
  @Prop pageId:string
  @State moduleData:Result[]=[]
  @State currentIndex:number=0

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
          this.moduleData = data.data[this.modules].docs.results
          hilog.info(0x0000, '请求成功', '小图列表moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', '小图列表moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        }
      })
      .catch((err: AxiosError<newSwiperItemType>) => {
        console.log('请求出错:', err.message);
      });
  }
  build() {
    Column(){
      Grid() {
        ForEach(this.moduleData, (item:Result,index) => { // 使用this.data代替this.moduleData
          GridItem(){
            Image(item.thumbnailUrl)
              .width('100%')
              .aspectRatio(16/9)

              .alt($r('app.media.defaultImage'))
          }
          .padding({left:5,right:5,bottom:5})
        },(item:Result)=>item._id)
      }
      .columnsTemplate('1fr 1fr')
    }
    .padding({top:10,bottom:10})
    .width('100%')
    .backgroundColor('#fff')
    .margin({top:MARGIN_TOP_Modules})
  }

}