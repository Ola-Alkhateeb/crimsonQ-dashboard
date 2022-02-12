<template>
  <!--begin::Dashboard-->
  <div class="row gy-5 gx-xl-8">
    <div class="col-xxl-12">
      <consumerList
        widget-classes="card-xxl-stretch mb-5 mb-xl-8"
      ></consumerList>
    </div>
  </div>
  <!--end::Dashboard-->
</template>

<script lang="ts">
import { defineComponent, onMounted } from "vue";
import consumerList from "./consumer_list.vue";
import { setCurrentPageTitle } from "@/core/helpers/breadcrumb";

export default defineComponent({
  name: "dashboard",
  components: {
    consumerList,
  },
  setup() {
    onMounted(() => {
      setCurrentPageTitle("Consumers List");
    });
  },
});
</script>
