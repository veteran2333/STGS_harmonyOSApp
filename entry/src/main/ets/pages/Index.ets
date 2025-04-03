import { queryMenusBaseInfoByProductId } from'../common/api/userApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import { MenuInfoResponse,MenuInfoResponseData} from '../common/type/userType';
import { hilog } from '@kit.PerformanceAnalysisKit';
import  HomePage  from './HomePage'
import uinfo from '../common/utils/getUserInfo'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State phoneNumber:string=''
  @State selectedIndex:number=0
  @State menuData:MenuInfoResponseData[]=[]
  @State selectedMenuId:string='default'

  onPageShow(): void {
    queryMenusBaseInfoByProductId(uinfo.getProductId(),uinfo.getYsUserId())
      .then((response: AxiosResponse<MenuInfoResponse>) => {
            const data = response.data;
            if (data&&data.code===0) {
              this.menuData = data.data
              hilog.info(0x0000, '请求成功', 'getmenuData : %{public}s', JSON.stringify(data) ?? '');
            } else {
              hilog.info(0x0000, '请求失败1', 'getmenuData : %{public}s', JSON.stringify(data) ?? '');
            }
          })
          .catch((err: AxiosError<MenuInfoResponse>) => {
            console.log('请求出错:', err.message);
          });
  }


  build() {
    RelativeContainer() {
      Column(){
        Tabs({barPosition:BarPosition.End}){
          // 遍历 menuData 生成 TabContent
          ForEach(this.menuData, (item: MenuInfoResponseData, index: number) => {
            TabContent() {
              HomePage({ selectedMenuId: item.menuId})
            }.tabBar(this.tabBuilder(index,item.name,item.customizeChosedIcon,item.customizeUnChosedIcon,item.chosedColor)) // 使用 menuName 作为 tabBar 的显示文本
          },(item:MenuInfoResponseData)=>item.menuId)
        }.onChange((Index:number)=>{
          this.selectedIndex = Index
          this.selectedMenuId = this.menuData[Index].menuId
          console.log('父',Index,this.selectedMenuId)

        })
        // Stack({ alignContent: Alignment.Bottom }) {
        //   Column(){
        //     HomePage({ selectedMenuId: this.selectedMenuId})
        //   }
        //     .height('100%')
        //     .padding({bottom:60})
        //   Row(){
        //     ForEach(this.menuData, (item: MenuInfoResponseData, index: number) => {
        //       Column(){
        //         Image(index===this.selectedIndex?item.customizeChosedIcon:item.customizeUnChosedIcon)
        //           .width(30)
        //         Text(item.name).fontColor(index===this.selectedIndex?item.chosedColor:'#2c2c2c')
        //       }.layoutWeight(1)
        //       .onClick(()=>{
        //         this.selectedIndex = index
        //         this.selectedMenuId = this.menuData[index].menuId
        //         console.log('父',Index,this.selectedMenuId)
        //       })
        //     },(item:MenuInfoResponseData)=>item.menuId)
        //   }
        //   .width('100%')
        //   .height(60)
        //   .backgroundColor('#fff')
        // }
        // .height('100%')
        // .width('100%')

      }
    }
    .height('100%')
    .width('100%')
  }


  @Builder
  tabBuilder(index: number, name: string, customizeChosedIcon: string,customizeUnChosedIcon:string,chosedColor:string) {
    Column(){
      Image(index===this.selectedIndex?customizeChosedIcon:customizeUnChosedIcon)
        .width(30)
      Text(name).fontColor(index===this.selectedIndex?chosedColor:'#2c2c2c')
    }
  }

}