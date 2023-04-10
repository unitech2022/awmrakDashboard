const rootRoute = "/";

const addProduct = "addProduct";
const addProductRoute = "/addProduct";


const overviewPageDisplayName = "الرئيسية";
const overviewPageRoute = "/overview";

const driversPageDisplayName = "الأقسام";
const driversPageRoute = "/drivers";

const productsPageDisplayName = "المتاجر";
const productsPageRoute = "/products";

const brandsPageDisplayName = "المديرون";
const brandsPageRoute = "/brands";

const slidersPageDisplayName = "البانر";
const slidersPageRoute = "/sliders";

const ordersPageDisplayName = "الطلبات";
const ordersPageRoute = "/orders";

const caresPageDisplayName = "الرعاية";
const caresPageRoute = "/cares";

const clientsPageDisplayName = "العملاء";
const clientsPageRoute = "/clients";
const sittingPageDisplayName = "الاعدادات";
const sittingPageRoute = "/sitting";
const authenticationPageDisplayName = "خروج";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}



List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(driversPageDisplayName, driversPageRoute),
  MenuItem(productsPageDisplayName, productsPageRoute),
  MenuItem(slidersPageDisplayName, slidersPageRoute),
  MenuItem(ordersPageDisplayName, ordersPageRoute),
  MenuItem(clientsPageDisplayName, clientsPageRoute),
  MenuItem(brandsPageDisplayName, brandsPageRoute),
  MenuItem(caresPageDisplayName, caresPageRoute),
  MenuItem(sittingPageDisplayName, sittingPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
