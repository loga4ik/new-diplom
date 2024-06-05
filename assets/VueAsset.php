<?php
/**
 * @link https://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license https://www.yiiframework.com/license/
 */

namespace app\assets;

use yii\web\AssetBundle;

/**
 * Main application asset bundle.
 *
 * @author Qiang Xue <qiang.xue@gmail.com>
 * @since 2.0
 */
class VueAsset extends AssetBundle
{
    public $basePath = '@webroot';
    public $baseUrl = '@web';
    public $css = [
        // 'css/site.css',
    ];
    public $js = [
        "https://unpkg.com/vue@3/dist/vue.global.js",
        // "https://cdn.jsdelivr.net/npm/vue@2",
        // "https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"
        // "https://cdn.jsdelivr.net/npm/dynamic-form-vue@0.0.9/dist/my-lib-cjs.min.js",
        
    ];
    public $depends = [
        'yii\web\YiiAsset',
        'yii\bootstrap5\BootstrapAsset'
    ];
}
