<template>
  <div class="about">
    <div>
      api root: {{ env.VITE_API_ROOT }}
    </div>
    <div v-for="user in users">
      <div>
        ID: {{ user.id }}
      </div>
      <div>
        Email: {{ user.email }}
      </div>
      <div>
        First Name: {{ user.firstName }}
      </div>
      <div>
        Last Name: {{ user.lastName }}
      </div>
    </div>
  </div>
</template>

<script lang="ts">
  import { defineComponent } from 'vue'
  import { getUser } from "../apis/UserApi";
  export default defineComponent({
    name: 'AboutView',
    data() {
      return {
        env: import.meta.env,
        users: [{
          id: '',
          email: '',
          firstName: '',
          lastName: '',
        }],
      }
    },
    methods: {
      async getData() {
        this.users = await getUser();
      }
    },
    async mounted() {
      await this.getData();
    },
  });
</script>

<style>
@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}
</style>
