
import { getSubscribeByMenuId } from'../common/api/userApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import uinfo from '../common/utils/getUserInfo';
import { ColumnInfoResponse,Page} from '../common/type/userType';
import { hilog } from '@kit.PerformanceAnalysisKit';

// 定义 params 接口
interface Params {
  productId: string;
}

// 定义 data 接口
interface Data {
  companyId: string;
  userId: string;
  productId: string;
  menuId: string;
}

@Component
export default  struct HomePage {
  @State message: string = 'Hello World';
  @State columnData:Page[]=[]
  @State selectedIndex:number=0
  @State isLoading: boolean = true;
  // 默认菜单
  @Prop selectedMenuId: string = 'default';
  // 默认第一个菜单的第一个导航
  @State selectedPageId:string=''

  aboutToAppear(): void {
    this.getColumnData()
  }
  getColumnData(){
    let params:Params = {productId:uinfo.getProductId() }
    let data:Data  = {
      companyId:uinfo.getYsCompanyId(),
      userId:uinfo.getYsUserId(),
      productId:uinfo.getProductId(),
      menuId:this.selectedMenuId||'default',
    }
    getSubscribeByMenuId(params,data)
      .then((response: AxiosResponse<ColumnInfoResponse>) => {
        const data = response.data;
        if (data&&data.code===0) {
          this.columnData = data.data.pages
          this.selectedPageId = this.columnData[0].pageId
          this.getPageData(this.selectedPageId,'')
          this.isLoading = false;
          hilog.info(0x0000, '请求成功', 'columnData : %{public}s', JSON.stringify(this.columnData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', 'columnData : %{public}s', JSON.stringify(this.columnData) ?? '');
        }
      })
      .catch((err: AxiosError<ColumnInfoResponse>) => {
        console.log('请求出错:', err.message);
      });
  }
  getPageData(pageId:string,productId:string){

  }
  build() {
      Column(){
        if (this.isLoading) {
          LoadingProgress()
            .color(Color.Blue)
            .layoutWeight(1)
        } else {
          Scroll() { // 添加Scroll组件
            Tabs({barPosition:BarPosition.Start}){
              ForEach(this.columnData, (item: Page, index: number) => {
                TabContent(){
                  Text(item.name+'页面')
                }.tabBar(this.tabBuilder(index,item.name))
              })
            }
            .onChange((Index:number)=>{
              this.selectedIndex = Index
            })
            .width('100%') // 设置宽度为100%
            .scrollable(true) // 启用滚动
            .barMode(BarMode.Scrollable) // 设置滚动模式
            .barWidth('100%') // 设置bar宽度
          }
          .scrollable(ScrollDirection.Horizontal) // 设置水平滚动
        }
      }
    .height('100%')
    .width('100%')
  }
  @Builder
  tabBuilder(index: number, name: string) {
    Column(){
      Text(name)
        .fontSize(16)
        .fontColor(index === this.selectedIndex ? '#64a089' : '#8E8E93') // 选中时蓝色，未选中时灰色
        .fontWeight(index === this.selectedIndex ? FontWeight.Bold : FontWeight.Normal) // 选中时加粗
    }
    .justifyContent(FlexAlign.Center)
    .padding(8)
  }
}
