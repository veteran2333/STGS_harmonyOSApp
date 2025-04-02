
import {newSwiperItemType,Result,liveList} from '../common/type/moduleType';
import {queryDatas} from '../common/api/moduleApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import { hilog } from '@kit.PerformanceAnalysisKit';
import uinfo from '../common/utils/getUserInfo';
import {MARGIN_TOP_Modules,Font_GRAY}from '../common/style/moduleVariables'
import { NewListDataClassSource } from '../common/utils/newListDataClassSource';


@Component
export default  struct bigPictureList {
  @Prop freshPageNum:number
  @Prop modules:string
  @Prop pageId:string
  @State moduleData:Result[]=[]
  @State currentIndex:number=0

  private  newsList:NewListDataClassSource = new NewListDataClassSource()
  newsInfo(arr:Result[]){
    if(arr&&arr.length){
      for (let index = 0; index < arr.length; index++) {
        this.newsList.pushData(arr[index])
      }
    }
  }
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
          this.newsInfo(this.moduleData)
          hilog.info(0x0000, '请求成功', '大图列表2moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', '大图列表2moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        }
      })
      .catch((err: AxiosError<newSwiperItemType>) => {
        console.log('请求出错:', err.message);
      });
  }
  build() {
    Column(){
      List(){
        LazyForEach(this.newsList, (item:Result,index) => { // 使用this.data代替this.moduleData
          ListItem(){
            Row(){
              Image(item.thumbnailUrl)
                .alt($r('app.media.defaultImage'))
                .height(60)
                .aspectRatio(47.5/60)
                .objectFit(ImageFit.Cover)
                .margin({right:10})
                .alt($r('app.media.defaultImage'))
              Column(){
                Text(item.name)
                  .fontSize(14)
                  .margin({top:10,bottom:10})
                Text(item.personBiography)
                  .fontColor(Font_GRAY)
                  .fontSize(10)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              Text('>')
                .fontColor(Font_GRAY)
            }
            .padding(10)
            .margin({top:5})
            .width('100%')
            .backgroundColor('#fff')
          }
        },(item:Result)=>item._id)
      }
    }
    .width('100%')
    // .backgroundColor('#fff')
    // .margin({top:MARGIN_TOP_Modules})
  }

}