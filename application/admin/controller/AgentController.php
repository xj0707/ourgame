<?php
namespace application\admin\controller;
class AgentController extends  CommonController{

    public function index(){
        $this->view->engine->layout(false);
        return $this->fetch();
    }

}