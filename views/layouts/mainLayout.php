<?php

/** @var yii\web\View $this */
/** @var string $content */

use app\assets\Admin2Asset;
use app\models\Role;
use yii\bootstrap5\Html as Bootstrap5Html;
use yii\bootstrap5\Nav;
use yii\bootstrap5\NavBar;
use yii\helpers\Html;

if (Yii::$app->user->isGuest) {
    $navLinks = [
        // ['label' => 'войти', 'url' => ['/site/login']]
    ];
} elseif (Yii::$app->user->identity->role_id == Role::getRoleId('manager')) {
    $navLinks = [
        ['label' => 'преподаватели', 'url' => ['/manager']],
        ['label' => 'добавление преподавателя', 'url' => ['/manager/teacher/create']],
        ['label' => 'группы', 'url' => ['/manager/group']],
    ];
} elseif (Yii::$app->user->identity->role_id == Role::getRoleId('teacher')) {
    $navLinks = [
        ['label' => 'студенты', 'url' => ['/teacher']],
        ['label' => 'добавление студента', 'url' => ['/teacher/teacher/create']],
        ['label' => 'группы', 'url' => ['/teacher/group']],
        ['label' => 'тесты', 'url' => ['/teacher/create-test']],
    ];
} elseif (Yii::$app->user->identity->role_id == Role::getRoleId('student')) {
    $navLinks = [
        ['label' => 'личный кабинет', 'url' => ['/student']],
        // ['label' => 'добавление преподавателя', 'url' => ['/manager/teacher/create']],
        // ['label' => 'группы', 'url' => ['/manager/group']],
    ];
}

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
            <img class="animation__shake" src="adminlte/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
        </div>

        <!-- Navbar -->
        <nav class="main-header navbar navbar-expand navbar-white navbar-light h-2">
            <!-- Left navbar links -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                </li>
                <li class="nav-item d-none d-sm-inline-block">
                    <?= Html::a('каталог', ['/'], ['class' => 'nav-link']) ?>
                    <!-- <a href="index3.html" class="nav-link">Home</a> -->
                </li>
            </ul>

            <!-- Right navbar links -->
            <ul class="navbar-nav ml-auto">
                <!-- Navbar Search -->
                <li class="nav-item">
                    <?php
                    NavBar::begin([
                        'options' => ['class' => 'sticky-top']
                    ]);
                    echo Nav::widget([
                        'options' => ['class' => 'navbar-nav'],
                        'items' => [
                            // ...$navLinks,
                            Yii::$app->user->isGuest
                                ? ['label' => 'Login', 'url' => ['/site/login']]
                                : '<li class="nav-item">'
                                . Html::beginForm(['/site/logout'])
                                . Html::submitButton(
                                    'Logout (' . Role::getRoleTitle(Yii::$app->user->identity->role_id) . ')',
                                    ['class' => 'nav-link btn btn-link logout']
                                )
                                . Html::endForm()
                                . '</li>'
                        ]
                    ]);
                    NavBar::end();
                    ?>
                </li>
            </ul>
        </nav>
        <!-- hello world -->
        <!-- /.navbar -->

        <!-- Main Sidebar Container -->
        <aside class="main-sidebar sidebar-dark-primary elevation-4">

            <div class="sidebar">
                <a href="<?= Yii::$app->homeUrl ?>" class="brand-link">
                    <!-- <img src="adminlte/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8"> -->
                    <span class="brand-text font-weight-light">
                        <?= Yii::$app->name ?>
                    </span>
                </a>

                <!-- Sidebar -->
                <!-- Sidebar user panel (optional) -->
                <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                    <div class="info">
                        <div class="d-block" style="color: #C7CAD2FF;">
                            role:
                            <?= Yii::$app->user->identity->login ?? 'необходимо войти'
                            ?>
                        </div>
                    </div>
                </div>

                <!-- Sidebar Menu -->
                <nav class="mt-2">
                    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

                        <?php
                        $getNavLinks = function ($navLinks) {
                            $string = '';
                            if (!is_null($navLinks)) {
                                # code...
                                foreach ($navLinks as $value) {
                                    $string .=  "<li class='nav-item'>
                                    <a class='nav-link' href=" . $value['url'][0] . "><p>" . $value['label'] . "</p></a>
                                    </li>";
                                }
                            }
                            return $string;
                        };
                        ?>
                        <?= $getNavLinks($navLinks) ?>

                    </ul>
                </nav>
            </div>
        </aside>

        <div class="content-wrapper">
            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <section class="col-lg-12 connectedSortable">
                            <?= $content
                            ?>
                        </section>
                    </div>
                </div>
            </section>
        </div>
        <!-- <footer class="main-footer">
            <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong>
            All rights reserved.
            <div class="float-right d-none d-sm-inline-block">
                <b>Version</b> 3.2.0
            </div>
        </footer> -->

        <aside class="control-sidebar control-sidebar-dark">
        </aside>
    </div>
    <header id="header">
        <h3>шаблон админ</h3>

    </header>

    <main id="main" class="flex-shrink-0">
    </main>

    <?php $this->registerJs("$.widget.bridge('uibutton', $.ui.button)") ?>

    <?php $this->endBody() ?>
</body>

</html>
<?php $this->endPage() ?>