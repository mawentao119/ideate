# ideate
#### Test base libraries and platform

I want to build a structure of test libraries. And add some convinient functions for creating auto-test case and executing them.

The basic idea is building it on three levels
- basic level
- servcie level
- case level

Then the testcase is just keywords and parameters.

# 爱迪亚特
#### 基础测试库与平台

后台系统的测试场景比较复杂，往往需要很多步骤，组成的测试用例的稳定性较差，编写出来的自动化用例也很冗长，难以维护。
基于自己的测试实践和思考，这里整理出分层实现测试公共库的思路，并逐步在实践中完善。

## 基本思路

- base层与service层 
  这个作为主要的两个层次，base主要面向基础操作封装，os层面的，远程基础库，结果比对，基础监控，用例生成，报告生成，基础的Web界面
  service主要是基于base，对于一些主要场景的封装。
- lib 与 resource 实现
  lib 主要实现 基础接口操作，属于命令、执行层面的封装，面向过程，返回一个命令的执行结果。
  resource 面向状态（结果）层面的封装，为了达到某种状态，里面可能会调用多个lib接口，处理可能的多种异常。

### 举例
- 创建一个用户
  如果用lib接口，直接返回结果，可能是用户已存在，可能是没有权限等等
  而resource接口，针对上面的异常，会进行自己的处理，如判断是否存在，是否符合要求，是否删除重建，是否可以用sudo权限进行操作处理，目的是尽量实现一个用户存在的状态。
  这对测试用例的稳定性会有很大的提升
  
  useradd 命令的封装放在 base 的lib中，而创建用户的操作可以封装在 base-resource 中。如果需要创建不同要求的用户，可以封装在Servcie的resource中

#### 通用的配置文件目录
- export IDEATE_DIR="~/ideate"
