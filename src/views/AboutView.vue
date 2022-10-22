<template>
  <div class="about">
    <h1>version(image tag / branch code): {{ env.VITE_APP_VERSION }} | </h1>
    <h2>server version: {{ serverVersion }} | </h2>
    <div style="color: aqua;">
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
import { getServerVersion } from "../apis/HealthCheck";
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
      serverVersion: '',
    }
  },
  methods: {
    async getData() {
      this.users = await getUser();
      this.serverVersion = await getServerVersion();
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
