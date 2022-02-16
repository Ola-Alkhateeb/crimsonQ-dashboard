<template>
  <!--begin::Layout Builder Notice-->
  <div class="card mb-10">
    <div class="card-body d-flex align-items-center py-8">
      <!--begin::Icon-->
      <div
      class="d-flex h-80px w-80px flex-shrink-0 flex-center position-relative"
      >
      <span class="svg-icon svg-icon-3x svg-icon-primary position-absolute">
        <img class="h-80px w-80px" src="media/details.png" />
      </span>
    </div>
    <!--end::Icon-->

    <!--begin::Description-->
    <div class="ms-12 col-lg-12">
      <div class="list-unstyled text-gray-600 fw-bold fs-6 p-0 m-0 row">
        <div class="col-lg-2 fw-bold text-muted">Concurrency :</div> <div class="col-lg-10 fw-bolder fs-6 text-gray-800"><span class="bullet bullet-dot bg-primary me-5"></span> {{consumer.concurrency}}</div>
        <div class="col-lg-2 fw-bold text-muted">Last Active at :</div> <div class="col-lg-10 fw-bolder fs-6 text-gray-800"><span class="bullet bullet-dot bg-primary me-5"></span> {{formatDate(consumer.lastActive)}}</div>
      </div>
      <div class="list-unstyled text-gray-600 fw-bold fs-6 p-0 m-0 row">
        <div class="col-lg-2 fw-bold text-muted">Topics : </div>
        <div class="col-lg-8">
          <div  class="fw-bolder fs-6 text-gray-800 " v-for="topic in consumer.topics" :key = "topic"> <span class="bullet bullet-dot bg-primary me-5"></span> {{topic}} </div> 
        </div>
        <div class="col-lg-2"><button class="btn btn-primary" @click=" this.$router.push('/dashboard')">Back</button></div>
      </div>
    </div>
    <!--end::Description-->
  </div>
</div>
<!--end::Layout Builder Notice-->

<div class="card mb-10">
  <!--begin::Header-->
  <div class="card-header card-header-stretch">
    <ul
    class="nav nav-stretch nav-line-tabs fw-bold border-0"
    role="tablist"
    id="kt_layout_builder_tabs"
    ref="kt_layout_builder_tabs"
    >

    <li class="nav-item">
      <a
      class="nav-link"
      :class="{ active: tabIndex === 0 }"
      data-bs-toggle="tab"
      @click="setActiveTab($event); getStatusData('pending')"
      data-tab-index="0"
      href="#kt_builder_main"
      role="tab"
      >
      <span style="margin-right: 5px;"> Pending </span><span class="badge badge-light-info" v-if="counts.pending"> {{ counts.pending}} </span>
    </a>
  </li>
  <li class="nav-item">
    <a
    class="nav-link"
    :class="{ active: tabIndex === 1 }"
    data-bs-toggle="tab"
    @click="setActiveTab($event ); getStatusData('active')"
    data-tab-index="1"
    href="#kt_builder_header"
    role="tab"
    >
    <span style="margin-right: 5px;"> Active </span><span class="badge badge-light-success" v-if="counts.active"> {{ counts.active}}</span>
  </a>
</li>
<li class="nav-item">
  <a
  class="nav-link"
  :class="{ active: tabIndex === 2 }"
  data-bs-toggle="tab"
  @click="setActiveTab($event); getStatusData('completed')"
  data-tab-index="2"
  href="#kt_builder_subheader"
  role="tab"
  >
  <span style="margin-right: 5px;"> Completed </span><span class="badge badge-light-success" v-if="counts.completed"> {{ counts.completed}}</span>
</a>
</li>
<li class="nav-item">
  <a
  class="nav-link"
  :class="{ active: tabIndex === 3 }"
  data-bs-toggle="tab"
  @click="setActiveTab($event); getStatusData('delayed')"
  data-tab-index="3"
  href="#kt_builder_aside"
  role="tab"
  >
  <span style="margin-right: 5px;"> Delayed </span><span class="badge badge-light-warning" v-if="counts.delayed"> {{ counts.delayed}}</span>
</a>
</li>
<li class="nav-item">
  <a
  class="nav-link"
  :class="{ active: tabIndex === 4 }"
  data-bs-toggle="tab"
  @click="setActiveTab($event ); getStatusData( 'failed')"
  data-tab-index="4"
  href="#kt_builder_content"
  role="tab"
  >
  <span style="margin-right: 5px;"> Failed </span><span class="badge badge-light-danger" v-if="counts.failed"> {{ counts.failed}}</span>
</a>
</li>
</ul>
</div>
<!--end::Header-->

<!--begin::Form-->
<div id="kt_layout_builder_form" style="background: #f5f8fa;">
  <!--begin::Body-->
  <div class="tab-content pt-3" id="kt_tabs">
    <div
    class="tab-pane active"
    id="kt_builder_main"
    >
    <div class="pull-right" >
      <button class="btn btn-sm btn-danger" style="margin: 5px;" v-if="(status === 'completed' || status === 'failed') && statusData.length != 0" @click="deleteStatuData(status)" > <em class="bi bi-trash"></em> Delete All</button>
      <button class="btn btn-sm btn-primary" v-if="status === 'failed' && statusData.length != 0" @click="retryAll()"><em class="bi bi-arrow-repeat" style="font-size: 15px;"></em> Retry All</button>
    </div>
    <div v-if="!statusData || statusData.length == 0" class="text-muted text-center h3"> No data available </div>
    <div v-for="record in statusData " :key="record.key"  class="card bgi-no-repeat h-xl-100" style="background-position: right top; background-size: 30% auto; background-image: url(media/svg/shapes/abstract-2.svg); margin-top: 5px; border: 1px solid rgb(226 227 229);" >
     <!--begin::Body-->
     <div class="card-body" style="padding: 1rem 1rem;">
       <div class="card-header" style="border-bottom: 0px; min-height: 0px; padding: 0px;">
        <a class="card-title fw-bolder text-muted text-hover-primary fs-4">Key : {{record.key}}</a>
        <div class="card-toolbar">
          <a class="btn btn-icon btn-bg-secondary btn-active-color-primary btn-sm me-1" @click="deleteMessage(record.key)">
            <a class="svg-icon svg-icon-3">
              <em class="bi bi-trash"></em>
            </a>
          </a>
          <a class="btn btn-icon btn-bg-secondary btn-active-color-primary btn-sm me-1" v-if="status == 'failed'">
            <a  class="svg-icon svg-icon-3" @click="retryMessage(record.key)" >
              <em class="bi bi-arrow-repeat" style="font-size: 15px;"></em>
            </a>
          </a>
        </div>
      </div>
      <div class="history-box">
        <div class="fw-bolder text-primary" v-for="(item, key) in record.statusHistory" :key="item">{{key}} : {{formatDate(item)}}</div>
      </div>
      <p class="text-dark-75 fw-bold fs-5 m-0 my-4">Message : {{record.value}}</p>
      <p class="text-dark-75 fw-bold fs-5 m-0 text-danger my-4" v-if="record.error"><span v-if="status != 'failed'">Previous </span>Error : {{record.error}}</p>
    </div>
  </div>
</div>
</div>
</div>

</div>

</template>
<style type="text/css">
.history-box{
  float: right;
  padding: 10px;
  margin:5px;
  border :1px solid #dddedf;
}
</style>
<script lang="ts">
import { defineComponent, onMounted, ref } from "vue";
import { config } from "@/core/helpers/config";
import { setCurrentPageTitle } from "@/core/helpers/breadcrumb";
import ApiService from "../core/services/ApiService";
import Swal from "sweetalert2/dist/sweetalert2.min.js";
import moment from 'moment-timezone';

export default defineComponent({
  name: "builder",
  components: {
  },
  data(){
    return {
      consumerId : this.$route.params.consumerId,
      consumer : {},
      statusData : [],
      counts :{},
      status : 'pending'
    }
  },
  mounted(){

    setCurrentPageTitle("Consumer " + this.$route.params.consumerId + " details");
    this.getTopics();
    this.getcounts();

    var status = localStorage.getItem("tabStatus") || 'pending';
    this.getStatusData(status)
  },
  methods :{
    getTopics(){
      ApiService.get('consumer/info/' + this.consumerId).then((d)=>{
        this.consumer = d.data;
      });
    },
    getcounts(){
      ApiService.get('msg/counts/' + this.consumerId).then((d)=>{
        this.counts = d.data;
      });
    },
    getStatusData(status){
      localStorage.setItem("tabStatus", status.toString());
      this.status = status
      ApiService.get('msg/list/json/' + this.consumerId +'/' + status).then((d)=>{
        this.statusData  = JSON.parse(d.data);
      });
    },
    deleteStatuData(status){
      let statusData = status == 'completed' ? 'complete' :status ;
      var payload = {consumerId : this.consumerId};
      var getStatusData = this.getStatusData
      var getcounts = this.getcounts

      ApiService.post(`consumer/flush/${statusData}`, payload).then((d)=>{
        getStatusData(status);
        getcounts();
      });
    },
    deleteMessage(messageId){
      var getStatusData = this.getStatusData
      var getcounts = this.getcounts
      var payload = {
        messageId : messageId,
        status : this.status,
        consumerId : this.consumerId
      };

      Swal.fire({
        text: "Are you sure you want to delete this message ?",
        icon: "warning",
        buttonsStyling: false,
        showCancelButton: true,
        confirmButtonText: "Delete",
        cancelButtonText: "Cancel",
        customClass: {
          confirmButton: "btn fw-bold btn-light-danger",
          cancelButton: "btn fw-bold btn-light-dark",
        },
      }).then(function ({isConfirmed}) {
        if(!isConfirmed){
          return;
        };
        ApiService.post(`msg/del`, payload).then(()=> {
          Swal.fire({
            text: "Message deleted successfully",
            icon: "success",
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
              confirmButton: "btn fw-bold btn-light-primary",
            },
          }).then(function () {
            getStatusData(payload.status);
            getcounts();
          });
        });
      });
    },
    retryMessage(messageId){
      var getStatusData = this.getStatusData;
      var getcounts = this.getcounts;
      var status = this.status;

      let payload = {
        messageId : messageId,
        consumerId : this.consumerId
      }
      ApiService.post(`msg/retry`, payload).then(()=> {
        Swal.fire({
          text: "Message retried successfully",
          icon: "success",
          buttonsStyling: false,
          confirmButtonText: "Ok, got it!",
          customClass: {
            confirmButton: "btn fw-bold btn-light-primary",
          },
        }).then(function () {
          getStatusData(status);
          getcounts();
        });
      });


    },
    retryAll(){
      var payload = {consumerId : this.consumerId};
      var getStatusData = this.getStatusData
      var getcounts = this.getcounts
      ApiService.post(`msg/retryall`, payload).then((d)=>{
        getStatusData('failed');
        getcounts();
      });
    },
    formatDate(date){
      return moment(date).format('DD/MM/YYYY hh:mm:ss ')
    }

  },

  setup() {
    const tabIndex = ref(0);

    onMounted(() => {
      tabIndex.value = parseInt(localStorage.getItem("builderTab") || "0");

    });

    /**
     * Reset config
     * @param event
     */
     const reset = (event) => {
      event.preventDefault();
      // remove existing saved config
      localStorage.removeItem("config");
      window.location.reload();
    };

    /**
     * Set active tab when the tab get clicked
     * @param event
     */
     const setActiveTab = (event ) => {
      tabIndex.value = parseInt(event.target.getAttribute("data-tab-index"));
      // keep active tab
      localStorage.setItem("builderTab", tabIndex.value.toString());
    };

    /**
     * Submit form
     * @param event
     */
     const submit = (event) => {
      event.preventDefault();
      // save new config to localStorage
      localStorage.setItem("config", JSON.stringify(config.value));
      window.location.reload();
    };

    return {
      tabIndex,
      config,
      reset,
      setActiveTab,
      submit
    };
  },
});
</script>
