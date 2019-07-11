import VueRouter from 'vue-router';
import AppPage from './app.vue';
import PostEditView from './components/PostEditView.vue';

const routes = [
{
  path: '/back/posts/:id/edit', 
  component: PostEditView,
},
]

export default new VueRouter({ routes });