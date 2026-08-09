<script>
  import IdeaTrend from './IdeaTrend.svelte';
  import IdeaDetail from './IdeaDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeIdea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="idea-panel">
  <IdeaTrend />
  <IdeaDetail />
  <CipherBadge />
  <p>{summarizeIdea(rows)}</p>
</div>

<style>
  .idea-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
