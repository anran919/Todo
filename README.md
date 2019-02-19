### 设计模式 ###   

#### 设计模式的六大原则 ####

- 开闭原则（Open Close Principle）

    对扩展开放，对修改关闭。在程序需要进行拓展的时候，不能去修改原有的代码，实现一个热插拔的效果.是为了使程序的扩展性好，易于维护和升级。想要达到这样的效果，我们需要使用接口和抽象类.
- 里氏代换原则（Liskov Substitution Principle） 

    里氏代换原则是面向对象设计的基本原则之一。 里氏代换原则中说，任何基类可以出现的地方，子类一定可以出现。LSP 是继承复用的基石，只有当派生类可以替换掉基类，且软件单位的功能不受到影响时，基类才能真正被复用，而派生类也能够在基类的基础上增加新的行为。里氏代换原则是对开闭原则的补充。实现开闭原则的关键步骤就是抽象化，而基类与子类的继承关系就是抽象化的具体实现，所以里氏代换原则是对实现抽象化的具体步骤的规范。

- 依赖倒转原则（Dependence Inversion Principle）

    这个原则是开闭原则的基础，具体内容：针对对接口编程，依赖于抽象而不依赖于具体。

- 接口隔离原则（Interface Segregation Principle）

    使用多个隔离的接口，比使用单个接口要好。它还有另外一个意思是：降低类之间的耦合度。由此可见，其实设计模式就是从大型软件架构出发、便于升级和维护的软件设计思想，它强调降低依赖，降低耦合。

- 迪米特法则，又称最少知道原则（Demeter Principle）

    最少知道原则是指：一个实体应当尽量少地与其他实体之间发生相互作用，使得系统功能模块相对独立。

- 合成复用原则（Composite Reuse Principle）

    合成复用原则是指：尽量使用合成/聚合的方式，而不是使用继承。

> 主要分为三种类型，创建型模式，结构型模式，行为型模式

**创建型模式**

 这些设计模式提供了一种在创建对象的同时隐藏创建逻辑的方式，而不是使用新的运算符直接实例化对象。这使得程序在判断针对某个给定实例需要创建哪些对象时更加灵活。

1. 工厂方法模式（静态工厂）
> 类似于工具类的，使用静态方法，一般不需要实例化
2. 抽象工厂方法模式
>  一个基础接口定义功能，一个工厂接口，产品实现基础接口，每个工厂实现工厂接口，新增产品只需要实现产品接口，然后定义一个该产品的工厂，实现工厂接口，返回这个产品的实例对象
3. 单例模式
> 私有构造方法，然后提供获取实例的方法，可以多种方法，包括懒汉式，饿汉式
4. 建造者模式
    ```
        public class Students {
        String name;
        int age;
        String id;


        public Students(StudentsBuilder builder) {
            this.age = builder.age;
            this.name = builder.name;
            this.id = builder.id;
        }


        @Override
        public String toString() {
            return "Students{" +
                    "name='" + name + '\'' +
                    ", age=" + age +
                    ", id='" + id + '\'' +
                    '}';
        }

        public static class StudentsBuilder {
            String name;
            int age;
            String id;

            public StudentsBuilder setName(String name) {
                this.name = name;
                return this;
            }

            public StudentsBuilder setAge(int age) {
                this.age = age;
                return this;
            }

            public StudentsBuilder setId(String id) {
                this.id = id;
                return this;
            }

            public Students build() {
                return new Students(this);
            }
        }
        }
    ```      

5. 原型模式
   
**结构型模式**

这些设计模式关注类和对象的组合。继承的概念被用来组合接口和定义组合对象获得新功能的方式

1. 适配器模式
2. 装饰器模式
3. 代理模式
为其他对象提供一种代理以控制对这个对象的访问。代理对象在客户端和目标对象之间起到中介的作用。

代理模式一般设计的角色有：
   1. 抽象角色 ： 申明代代理对象和真实对象的共同接口
   2. 代理角色 ： 代理对象角色内部包含也有对真实对象的引用，从而可以操作真实对象，同时代理对象提供与真实对象相同对接口，以便在任何时刻都能代替真实对象，同时，代理对象可以在执行真实对象操作时，附加其他操作，相当于对真实对象的封装。
   3. 真实角色 ：  代理角色所代表的真实对象，是我们最终要引用对对象    
    
- 静态代理
```java
public interface IDogSubject {
    void  eat();
}
```
```java
public class Dog  implements IDogSubject {
    @Override
    public void eat() {
        System.out.println("dog" +"吃骨头");
    }
}
```
```java
/**
 * 代理对象中获取真实对象的实例，并在调用其方法，可以在方法获取实例前后做其他操作
 */
public class DogProxy implements IDogSubject {
    private Dog dog;
    @Override
    public void eat() {
        init();
        if (dog == null) {
            dog = new Dog();
        }
        dog.eat();
        doAfter();
    }
    private void doAfter() {}
    private void init() {}
}

```
- 动态代理 
> 动态代理， 它是在运行时生成的class，在生成它时你必须提供一组interface给它， 然后该class就宣称它实现了这些interface。
你当然可以把该class的实例当作这些interface中的任何一个来用。 当然啦，这个Dynamic
Proxy其实就是一个Proxy，它不会替你作实质性的工作， 在生成它的实例时你必须提供一个handler，由它接管实际的工作。
```java
public interface ICatSubject {
    void eat(String food);
}
```
```java
public class Cat implements ICatSubject {
    @Override
    public void eat(String food) {
        System.out.println("cat eat"+food);
    }
}

```
```java
public class CatProxy implements InvocationHandler {
    private  Object sub;
    public CatProxy(Object sub) {
        this.sub = sub;
    }
    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println(" ============== before call ==============");
        method.invoke(sub,args);
        System.out.println(" ============== after  call ==============");
        return null;
    }
}
```
   
1. 桥接模式
2. 享元模式
3. 组合模式
  
**行为型模式**
1. 观察者模式
1. 模版方法模式
1. 策略模式
1. 迭代子模式
1. 责任链模式
1. 命令模式
1. 备忘录模式
1. 状态模式
1. 访问者模式
1. 中介者模式
1. 解释器模式
  
### 自定义view


### 事件分发
### 图片（Glide）
**Glide**
- 性能方面比Picasso要好
- Glide默认提供配置支持本地图片缓存,缓存的机制是DiskLruCache.可以根据自己的需要,自定义图片缓存的路径

**Picaso**
- Picasso不支持磁盘缓存,如果需要可以使用（DiskLruCache)

**Fresco**
- 在Android 5.0以下系统，图片不存储在Java heap，而是存储在ashmemheap，中间的字节buffer同样位于native heap。使应用有更多内存空间，降低OOM风险，减少GC次数。
渐进式的JPEG呈现。

- 图片可以在任意点进行裁剪，而不是中心，即自定义居中焦点。
JPEG可以在native进行resize，避免了在缩小图片时的OOM风险。

- 支持Gif和WebP。
- 所以Fresco的体积比较庞大，会为应用增加接近2M的体积，这算是Fresco的一个缺点

**选择**
- 虽然Fresco也提供更强大的图片缓存和加载机制,不过在比较之后,感觉Fresco还是有待完善.Glide可以很简单的获取网络图片的Bitmap对象,而Fresco需要通过订阅数据源克隆Bitmap对象的引用才能存储值.操作方式不够简洁和友好.
- Fresco的库文件中,以最新的0.8.1为例,imagepipeline-0.8.1.aar光包得大小就有3.5M ,而Glide包的大小为465K为了让Apk包得体积更小,所以考虑使用Glide.

### 网络请求（Retrofit）
**OkHttp简单使用**
```java
String url = "http://wwww.baidu.com";
OkHttpClient okHttpClient = new OkHttpClient();
final Request request = new Request.Builder()
        .url(url)
        .get()//默认就是GET请求，可以不写
        .build();
Call call = okHttpClient.newCall(request);
call.enqueue(new Callback() {
    @Override
    public void onFailure(Call call, IOException e) {
        Log.d(TAG, "onFailure: ");
    }

    @Override
    public void onResponse(Call call, Response response) throws IOException {
        Log.d(TAG, "onResponse: " + response.body().string());
    }
});
```

**拦截器**

- [Okhttp3基本使用](https://www.jianshu.com/p/da4a806e599b)


**Retrofit**
>Retrofit2简单的说就是一个网络请求的适配器，它将一个基本的Java接口通过动态代理的方式翻译成一个HTTP请求，并通过OkHttp去发送请求。此外它还具有强大的可扩展性，支持各种格式转换以及RxJava
- 简单使用
```java
 Retrofit retrofit = new Retrofit.Builder().baseUrl("www.xxxx.com/").build();
        PersonalProtocol personalProtocol = retrofit.create(PersonalProtocol.class);
        Call<Response<PersonalInfo>> call = personalProtocol.getPersonalListInfo(12);
        call.enqueue(new Callback<Response<PersonalInfo>>() {
            @Override
            public void onResponse(Call<Response<PersonalInfo>> call, Response<Response<PersonalInfo>> response) {
                //数据请求成功
            }

            @Override
            public void onFailure(Call<Response<PersonalInfo>> call, Throwable t) {
                //数据请求失败
            }
        });
```
- 
### Rx(RxJava)
>一个在 Java VM 上使用可观测的序列来组成异步的、基于事件的程序的库
#### [常用的API](https://www.jianshu.com/p/0cd258eecf60)
- 快捷创建事件队列 （``just()``,``from()``,``creat()``）
- 订阅事件（``Observable.subscribe(...)``）
- 线程控制 （``Scheduler``）
- 转换（``map()``,``flatMap()``）
- concat(``concat()``),不交错的发送两个深知多个Observable的发射事件，等前一个``onComplete``后才会订阅下一个Observable，实际使用当我们需要先读取缓存，没有缓存再请求网络等时候
- zip(``zip()``)专用于合并事件，该合并不是连接（连接操作符后面会说），而是两两配对，也就意味着，最终配对出的 Observable 发射事件数目只和少的那个相同。
- FlatMap(``FlatMap()``)flatMap 并不能保证事件的顺序，如果需要保证，需要用到ConcatMap
- distinct(``distinct()``) 去重
- Filter（``Filter()``）过滤
- buffer（``buffer(count,skip)``）分组，count数量，skip长度，我是这样理解的
- interval （``interval(3,2, TimeUnit.SECONDS)``）,参数分别是第一次发送延迟，间隔时间，时间单位
- skip（``skip(count)``）跳过count
- take（``take``）take，接受一个 long 型参数 count ，代表至多接收 count 个数据

#### 配合Retrofit
接口返回一个Observable
```java
@GET("/user")
public Observable<User> getUser(@Query("userId") String userId);
```
```java
getUser(userId)
    .observeOn(AndroidSchedulers.mainThread())
    .subscribe(new Observer<User>() {
        @Override
        public void onNext(User user) {
            userView.setUser(user);
        }

        @Override
        public void onCompleted() {
        }

        @Override
        public void onError(Throwable error) {
            ...
        }
    });
```

### RxBinding

### MVP(MVVM)



- 易方达中小盘混合 
- 易方达上证50指数A  
- 富国中证红利指数增强

- 富国中证500
- 东方红沪港深 002803
- 交银优势行业混合(519697)


 


