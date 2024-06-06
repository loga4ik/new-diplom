<?php

/** @var yii\web\View $this */

use yii\bootstrap5\Html;

$this->title = 'My Yii Application';
if (!Yii::$app->user->isGuest) {
    # code...
    if (Yii::$app->user->identity->role_id == 4) {
        # code...
        Yii::$app->response->redirect('/student');
    } elseif (Yii::$app->user->identity->role_id == 3) {
        Yii::$app->response->redirect('/teacher');
        # code...
    } elseif (Yii::$app->user->identity->role_id == 2) {
        Yii::$app->response->redirect('/manager');
        # code...
    }
}
?>
<div class="site-index">

    <div class="jumbotron text-center bg-transparent mt-5 mb-5">
        <h1 class="display-4">Тяжело в учении легко в тестировании!</h1>

        <p><?= Html::a('войти', '/site/login', ['class' => 'btn  btn-lg my-btn-success']) ?></p>
    </div>

    <div class="body-content">

        <div class="row">
            <div class="col ch300 mb-3">
                <a href="https://spb-rtk.ru/%d1%81%d0%b5%d1%82%d0%b5%d0%b2%d0%be%d0%b5-%d0%b8-%d1%81%d0%b8%d1%81%d1%82%d0%b5%d0%bc%d0%bd%d0%be%d0%b5-%d0%b0%d0%b4%d0%bc/" class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image:  url('https://spb-rtk.ru/wp-content/themes/spbrtk_s/images/s4.jpg'); border: 0;  ">
                    <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
                        <h4 class="pt-5 mt-5 mb-4 lh-1 fw-bold">Сетевое и системное администрирование<br></h4>
                    </div>
                </a>
            </div>
            <div class="col ch300 mb-3">
                <a href="https://spb-rtk.ru/%d0%b8%d1%81-%d0%b8-%d0%bf%d1%80%d0%be%d0%b3%d1%80%d0%b0%d0%bc%d0%bc%d0%b8%d1%80%d0%be%d0%b2%d0%b0%d0%bd%d0%b8%d0%b5/" class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('https://spb-rtk.ru/wp-content/themes/spbrtk_s/images/s6.jpg'); border: 0;  ">
                    <div class="d-flex flex-column h-100 p-5 pb-3 text-shadow-1">
                        <h4 class="pt-5 mt-5 mb-4 lh-1 fw-bold">Информационные системы и программирование<br></h4>
                    </div>
                </a>
            </div>
            <div class="col ch300 mb-3">
                <a href="https://spb-rtk.ru/%d0%bd%d0%b0%d0%bb%d0%b0%d0%b4%d1%87%d0%b8%d0%ba-%d0%b0%d0%bf%d0%bf%d0%b0%d1%80%d0%b0%d1%82%d0%bd%d0%be%d0%b3%d0%be-%d0%b8-%d0%bf%d1%80%d0%be%d0%b3%d1%80%d0%b0%d0%bc%d0%bc%d0%bd%d0%be%d0%b3%d0%be/" class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image:  url('https://spb-rtk.ru/wp-content/themes/spbrtk_s/images/s5.jpg');border: 0;   ">
                    <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
                        <h4 class="pt-5 mt-5 mb-4 lh-1 fw-bold">Наладчик аппаратного и программного обеспечения<br></h4>
                    </div>
                </a>
            </div>
        </div>

    </div>
</div>