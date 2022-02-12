<template>
  <!--begin::Layout Builder Notice-->
  <div class="card mb-10">
    <div class="card-body d-flex align-items-center py-8">
      <!--begin::Icon-->
      <div
      class="d-flex h-80px w-80px flex-shrink-0 flex-center position-relative"
      >
      <span class="svg-icon svg-icon-primary position-absolute opacity-15">
        <inline-svg
        src="media/icons/duotune/abstract/abs051.svg"
        class="h-80px w-80px"
        />
      </span>
      <span class="svg-icon svg-icon-3x svg-icon-primary position-absolute">
        <inline-svg src="media/icons/duotune/coding/cod002.svg" />
      </span>
    </div>
    <!--end::Icon-->

    <!--begin::Description-->
    <div class="ms-12 col-lg-12">
      <div class="list-unstyled text-gray-600 fw-bold fs-6 p-0 m-0 row">
        <div class="col-lg-2 fw-bold text-muted">Topics : </div>
        <div class="col-lg-8">
          <div  class="fw-bolder fs-6 text-gray-800 " v-for="topic in topics" :key = "topic"> {{topic}} </div> 
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
<div id="kt_layout_builder_form">
  <!--begin::Body-->
  <div class="tab-content pt-3" id="kt_tabs">
    <div
    class="tab-pane"
    :class="{ active: tabIndex === 0 }"
    id="kt_builder_main"
    >
    <!-- <div v-for="record in statusData " :key="$index" > -->
      <div class="card bgi-no-repeat h-xl-100" style="background-position: right top; background-size: 30% auto; background-image: url(media/svg/shapes/abstract-2.svg); border:1px solid #eff2f5 margin-top:5px;" >
       <!--begin::Body-->
       <div class="card-body">
        <a href="#" class="card-title fw-bolder text-muted text-hover-primary fs-4">Meeting Schedule</a>
        <div class="fw-bolder text-primary my-6">03 May 2020</div>
        <p class="text-dark-75 fw-bold fs-5 m-0">Great blog posts don’t just happen Even the best bloggers need it</p>
      </div>
      <!-- </div> -->
    </div>
  </div>

  <div
  class="tab-pane"
  :class="{ active: tabIndex === 1 }"
  id="kt_builder_header"
  >
  <div class="row mb-10">

  </div>

</div>

<div
class="tab-pane"
:class="{ active: tabIndex === 2 }"
id="kt_builder_subheader"
>
<div class="row mb-10">

</div>
</div>

<div
class="tab-pane"
:class="{ active: tabIndex === 3 }"
id="kt_builder_aside"
>
<div class="row mb-10">

</div>
</div>

<div
class="tab-pane"
:class="{ active: tabIndex === 4 }"
id="kt_builder_content"
>
<div class="row mb-10">

</div>
</div>

<div
class="tab-pane"
:class="{ active: tabIndex === 5 }"
id="kt_builder_footer"
>
<div class="row mb-10">

</div>
</div>
</div>
</div>
<!--end::Body-->

<!--end::Form-->
</div>

</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from "vue";
import { config } from "@/core/helpers/config";
import { themeName } from "@/core/helpers/documentation";
import { setCurrentPageTitle } from "@/core/helpers/breadcrumb";
import ApiService from "../core/services/ApiService";

export default defineComponent({
  name: "builder",
  components: {
  },
  data(){
    return {
      consumerId : this.$route.params.consumerId,
      topics : [],
      statusData : [],
      counts :{}
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
      ApiService.get('consumer/topics/get/' + this.consumerId).then((d)=>{
        this.topics = d.data;
      });
    },
    getcounts(){
      ApiService.get('msg/counts/' + this.consumerId).then((d)=>{
        this.counts = d.data;
      });
    },
    getStatusData(status){
      localStorage.setItem("tabStatus", status.toString());

      ApiService.get('msg/list/json/' + this.consumerId +'/' + status).then((d)=>{
        console.log(JSON.parse(d.data))
        this.statusData  = JSON.parse(d.data);
      });
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
      submit,
      themeName,
    };
  },
});
</script>
