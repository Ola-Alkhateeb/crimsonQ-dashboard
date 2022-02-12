<template>
  <!--begin::Tables Widget 9-->
  <div class="card" :class="widgetClasses">
    <!--begin::Header-->
    <div class="card-header border-0 pt-5">
      <h3 class="card-title align-items-start flex-column">
        <span class="card-label fw-bolder fs-3 mb-1">Consumers</span>
      </h3>
      <div
      class="card-toolbar"
      data-bs-toggle="tooltip"
      data-bs-placement="top"
      data-bs-trigger="hover"
      title="Click to add a user"
      >
      <a
      href="#"
      class="btn btn-sm btn-light-primary"
      data-bs-toggle="modal"
      data-bs-target="#kt_modal_invite_friends"
      >
      <span class="svg-icon svg-icon-3">
        <inline-svg src="media/icons/duotune/arrows/arr075.svg" />
      </span>
      New Member
    </a>
  </div>
</div>
<!--end::Header-->

<!--begin::Body-->
<div class="card-body py-3">
  <!--begin::Table container-->
  <div class="table-responsive">
    <!--begin::Table-->
    <table
    class="table table-row-dashed table-row-gray-300 align-middle gs-0 gy-4"
    >
    <!--begin::Table head-->
    <thead>
      <tr class="fw-bolder text-muted">
        <th class="min-w-150px">Name</th>
        <th class="min-w-100px text-end">Actions</th>
      </tr>
    </thead>
    <!--end::Table head-->

    <!--begin::Table body-->
    <tbody>
      <template v-for="(item, index) in list" :key="index">
        <tr>
          <td>
            <div class="d-flex align-items-center">
              <div class="symbol symbol-45px me-5">
                <img src="media/crimsonq.png" alt="" />
              </div>
              <div class="d-flex justify-content-start flex-column">
                <a
                class="text-dark fw-bolder text-hover-primary fs-6"
                >{{ item }}</a
                >
              </div>
            </div>
          </td>

          <td class="text-end">
            <a
            class="btn btn-icon btn-bg-light btn-active-color-primary btn-sm me-1"
            >
            <a class="svg-icon svg-icon-3" @click="goToConsumer(item)">
              <em class="fa fa-eye"></em>
            </a>
          </a>

          <a
          class="btn btn-icon btn-bg-light btn-active-color-primary btn-sm"
          >
          <span class="svg-icon svg-icon-3">
            <inline-svg
            src="media/icons/duotune/general/gen027.svg"
            />
          </span>
        </a>
      </td>
    </tr>
  </template>
</tbody>
<!--end::Table body-->
</table>
<!--end::Table-->
</div>
<!--end::Table container-->
</div>
<!--begin::Body-->
</div>
<!--end::Tables Widget 9-->
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
import ApiService from "@/core/services/ApiService";


export default defineComponent({
  name: "kt-widget-9",
  components: {},
  props: {
    widgetClasses: String
  },
  data() {
    return {
      list :[]
    };
  },
  mounted(){
    this.requestData();
  },
  methods:{
   requestData() {
    ApiService.get('/consumer/list').then((d)=>{
      this.list = d.data;
    });
  },
  goToConsumer(item){
    this.$router.push("/consumer/" + item)
  }
}
});
</script>
