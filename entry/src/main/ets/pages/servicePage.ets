
import { getSubscribeByMenuId,queryModules } from'../common/api/userApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import uinfo from '../common/utils/getUserInfo';
import { ColumnInfoResponse,Page,pageInfoResponse,pageDataType} from '../common/type/userType';
import { hilog } from '@kit.PerformanceAnalysisKit';
import  ModuleList from '../component/ModuleList'
import H5Links from '../component/H5Links'

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
export default  struct servicePage {
  @State columnData:Page[]=[]
  @State selectedIndex:number=0
  @State isLoading: boolean = true;
  // 默认菜单
  @Prop selectedMenuId: string = 'default';
  // @Prop @Watch('selectedMenuIdChange')selectedMenuId: string = 'default';
  // 默认第一个菜单的第一个导航
  @State selectedPageId:string=''
  @State pageData:pageDataType[]=[]
  @Prop menuName:string=''

  scroller: Scroller = new Scroller()
  // 下拉刷新
  @State isRefreshing: boolean = false
  // 下拉了几次
  @State freshPageNum:number = 1


  selectedMenuIdChange():void{
    this.getColumnData()
  }
  aboutToAppear(): void {
    this.getColumnData()
    hilog.info(0x0000, '请求成功', '服务导航columnData : %{public}s', JSON.stringify(this.columnData) ?? '');
  }
  // 获取导航
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
          this.getPageData(this.selectedPageId,uinfo.getProductId())
          this.isLoading = false;
          hilog.info(0x0000, '请求成功', '导航columnData : %{public}s', JSON.stringify(this.columnData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', '导航columnData : %{public}s', JSON.stringify(this.columnData) ?? '');
        }
      })
      .catch((err: AxiosError<ColumnInfoResponse>) => {
        console.log('请求出错:', err.message);
      });
  }

  // 获取导航内模块
  getPageData(pageId:string,productId:string){
    queryModules(pageId,productId)
      .then((response: AxiosResponse<pageInfoResponse>) => {
        const data = response.data;
        if (data&&data.code===0) {
          this.pageData = data.data
          hilog.info(0x0000, '请求成功', '模块列表pageData : %{public}s', JSON.stringify(this.pageData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', '模块列表pageData : %{public}s', JSON.stringify(this.pageData) ?? '');
        }
      })
      .catch((err: AxiosError<pageInfoResponse>) => {
        console.log('请求出错:', err.message);
      });
  }
  build() {



        Column(){
          if (this.isLoading) {
            LoadingProgress()
              .color(Color.Blue)
              .layoutWeight(1)
          } else {
              Text(this.menuName)
                .fontSize(16)
                .fontColor('#44999a' ) // 选中时蓝色，未选中时灰色
                .fontWeight( FontWeight.Bold) // 选中时加粗
                .margin(10)

            // Scroll() { // 添加Scroll组件
            //   Row(){
            //     ForEach(this.columnData, (item: Page, index: number) => {
            //       Text(item.name)
            //         .fontSize(16)
            //         .fontColor(index === this.selectedIndex ? '#44999a' : '#666666') // 选中时蓝色，未选中时灰色
            //         .fontWeight(index === this.selectedIndex ? FontWeight.Bold : FontWeight.Normal) // 选中时加粗
            //         .margin(10)
            //         .onClick(()=>{
            //           this.selectedIndex = index
            //           this.selectedPageId = this.columnData[index].pageId
            //           this.getPageData(this.selectedPageId,uinfo.getProductId())
            //         })
            //     },(item:Page) => item.circleId)
            //   }
            // }
            // .scrollable(ScrollDirection.Horizontal) // 设置水平滚动
            // ModuleList({ modeLIstData: this.pageData,clickPageitem:this.columnData[this.selectedIndex].name })


            Scroll(this.scroller) {
                Refresh({ refreshing: $$this.isRefreshing }) {
                  List() {
                    ForEach(this.pageData, (item: pageDataType) => {
                      ListItem() {
                        H5Links({ pageId: item.pageId, modules: item._id, freshPageNum: this.freshPageNum })
                      }
                    }, (item: pageDataType) => item._id)
                  }

                }
                .onStateChange((refreshStatus: RefreshStatus) => {
                  console.info('Refresh onStatueChange state is ' + refreshStatus)
                })
                .onOffsetChange((value: number) => {
                  console.info('Refresh onOffsetChange offset:' + value)
                })
                .onRefreshing(() => {
                  setTimeout(() => {
                    this.isRefreshing = false
                  }, 2000)
                  console.log('onRefreshing test')
                })
                .backgroundColor('#ecf1f9')
                .refreshOffset(64)
                .pullToRefresh(true)
                .height('100%')
            }
            .padding({bottom:40})
            .width('100%')
          }
        }
  }
  @Builder
  tabBuilder(index: number, name: string) {
    Column(){
      Text(name)
        .fontSize(16)
        .fontColor(index === this.selectedIndex ? '#44999a' : '#666666') // 选中时蓝色，未选中时灰色
        .fontWeight(index === this.selectedIndex ? FontWeight.Bold : FontWeight.Normal) // 选中时加粗
    }
    .justifyContent(FlexAlign.Center)
    .padding(8)
  }
}
