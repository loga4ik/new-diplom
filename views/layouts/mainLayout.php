<?php

/** @var yii\web\View $this */
/** @var string $content */

use app\assets\Admin2Asset;
use app\models\Role;
use app\models\Test;
use app\models\User;
use yii\bootstrap5\Html as Bootstrap5Html;
use yii\bootstrap5\Nav;
use yii\bootstrap5\NavBar;
use yii\helpers\Html;

if (Yii::$app->user->isGuest) {
    $navLinks = [
        ['label' => 'войти', 'url' => ['/site/login']]
    ];
} elseif (Yii::$app->user->identity->role_id == Role::getRoleId('manager')) {
    $navLinks = [
        ['label' => '<i class="nav-icon fi fi-rr-user"></i> <p>преподаватели</p>', 'url' => ['/manager']],
        ['label' => '<i class="nav-icon fi fi-rr-user-add"></i> <p>добавление преподавателя</p>', 'url' => ['/manager/teacher/create']],
        ['label' => '<i class="nav-icon fi-rr-users-alt"></i> <p>группы</p>', 'url' => ['/manager/group']],
        ['label' => '<i class="fi fi-rr-book-alt"></i> &nbsp; <p>предметы</p>', 'url' => ['/manager/subject']],
    ];
} elseif (Yii::$app->user->identity->role_id == Role::getRoleId('teacher')) {
    $navLinks = [
        ['label' => '<i class="nav-icon fi fi-rr-user"></i> <p>студенты</p>', 'url' => ['/teacher']],
        ['label' => ' <i class="nav-icon fi fi-rr-user-add"></i> <p>добавление студента</p>', 'url' => ['/teacher/student/create']],
        ['label' => '<i class="nav-icon fi-rr-users-alt"></i> <p>группы</p>', 'url' => ['/teacher/group']],
        ['label' => '<i class="nav-icon fi fi-rr-document"></i>  <p>тесты</p>', 'url' => ['/teacher/test']],
    ];
} elseif (Yii::$app->user->identity->role_id == Role::getRoleId('student')) {
    $navLinks = [
        ['label' => '<i class="nav-icon fi-rr-users-alt"></i> <p>личный кабинет</p>', 'url' => ['/student']],
        Test::getFindActiveTest() ?
            ['label' => '<i class="nav-icon fi-rr-users-alt"></i> <p>Решить активный тест</p>', 'url' => ['/student/test']] : [],
        // ['label' => 'добавление преподавателя', 'url' => ['/manager/teacher/create']],
        // ['label' => 'группы', 'url' => ['/manager/group']],
    ];
} elseif (Yii::$app->user->identity->role_id == Role::getRoleId('admin')) {
    $navLinks = [
        ['label' => '<i class="nav-icon fi-rr-users-alt"></i> <p>личный кабинет</p>', 'url' => ['/student']],
        // ['label' => 'добавление преподавателя', 'url' => ['/manager/teacher/create']],
        // ['label' => 'группы', 'url' => ['/manager/group']],
    ];
}

$getNavLinks = function ($navLinks) {
    $string = '';
    if (!is_null($navLinks)) {
        # code...
        foreach ($navLinks as $value) {
            if (!$value) {
                break;
            }
            $string .=  "<li class='nav-item'>
            <a class='nav-link' href=" . $value['url'][0] . ">" . $value['label'] . "</a>
            </li>";
        }
    }
    return $string;
};
Admin2Asset::register($this);

$this->registerCsrfMetaTags();
$this->registerMetaTag(['charset' => Yii::$app->charset], 'charset');
$this->registerMetaTag(['name' => 'viewport', 'content' => 'width=device-width, initial-scale=1, shrink-to-fit=no']);
$this->registerMetaTag(['name' => 'description', 'content' => $this->params['meta_description'] ?? '']);
$this->registerMetaTag(['name' => 'keywords', 'content' => $this->params['meta_keywords'] ?? '']);
$this->registerLinkTag(['rel' => 'icon', 'type' => 'image/x-icon', 'href' => Yii::getAlias('@web/favicon.ico')]);
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>" class="h-100">

<head>
    <title>
        <?= Html::encode($this->title) ?>
    </title>
    <?php $this->head() ?>
</head>

<body class="hold-transition sidebar-mini layout-fixed">
    <?php $this->beginBody() ?>
    <div class="wrapper">

        <!-- Preloader -->
        <div class="preloader flex-column justify-content-center align-items-center">
            <img class="animation__shake" src="/web/adminlte/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
        </div>

        <!-- Navbar -->
        <nav class="main-header navbar navbar-expand navbar-white navbar-light">
            <!-- Left navbar links -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto">
                <!-- Navbar Search -->
                <?=
                Yii::$app->user->isGuest
                    ? Html::a(
                        'Войти',
                        '/site/login',
                        ['class' => 'nav-link btn btn-link logout']
                    )
                    : '<li class="nav-item">'
                    . Html::beginForm(['/site/logout'])
                    . Html::submitButton(
                        'Выйти (' . User::findOne(['login' => Yii::$app->user->identity->login])->name . ')',
                        ['class' => 'nav-link btn btn-link logout']
                    )
                    . Html::endForm()
                    . '</li>'
                ?>
            </ul>
        </nav>
        <!-- /.navbar -->

        <!-- Main Sidebar Container -->
        <aside class="main-sidebar sidebar-dark-primary elevation-4">
            <!-- Brand Logo -->
            <a href="index3.html" class="brand-link">
                <img src="/web/adminlte/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
                <span class="brand-text font-weight-light">
                    <?=
                    Yii::$app->name;
                    ?>
                </span>
            </a>

            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Sidebar user panel (optional) -->
                <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                    <!-- <div class="image">
                        <img src="adminlte/dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
                    </div> -->
                    <div class="info">
                        <span class="d-block" style="color: #C7CAD2FF;">
                            <?php $roleArr = [
                                'admin' => 'администратор',
                                'manager' => 'менеджер',
                                'teacher' => 'преподаватель',
                                'student' => 'студент',

                            ] ?>
                            роль:
                            <?= !Yii::$app->user->isGuest ? $roleArr[Role::getRoleTitle(Yii::$app->user->identity->role_id)] : 'необходимо войти'
                            ?>
                        </span>
                    </div>
                </div>

                <!-- Sidebar Menu -->
                <nav class="mt-2">
                    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                        <!-- Add icons to the links using the .nav-icon class
             with font-awesome or any other icon font library -->

                        <?= $getNavLinks($navLinks) ?>
                    </ul>
                </nav>
                <!-- /.sidebar-menu -->
            </div>
            <!-- /.sidebar -->
        </aside>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->

            <!-- /.content-header -->

            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <!-- /.row -->
                    <!-- Main row -->
                    <div class="row">
                        <!-- Left col -->
                        <section class="col-lg-12 connectedSortable">
                            <?= $content ?>
                        </section>
                        <!-- /.Left col -->
                        <!-- right col (We are only adding the ID to make the widgets sortable)-->

                        <!-- right col -->
                    </div>
                    <!-- /.row (main row) -->
                </div><!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
        <!-- <footer class="main-footer">
            <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong>
            All rights reserved.
            <div class="float-right d-none d-sm-inline-block">
                <b>Version</b> 3.2.0
            </div>
        </footer> -->

        <!-- Control Sidebar -->
        <aside class="control-sidebar control-sidebar-dark">
            <!-- Control sidebar content goes here -->
        </aside>
        <!-- /.control-sidebar -->
    </div>

    <main id="main" class="flex-shrink-0">
        <!--  role="main" -->
    </main>

    <? # $this->registerJs("$.widget.bridge('uibutton', $.ui.button)") 
    ?>

    <?php $this->endBody() ?>
</body>

</html>
<?php $this->endPage() ?>