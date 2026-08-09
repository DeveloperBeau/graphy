<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForIdea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="idea-trend">
  <TrendSparkline />
  <p>{trendForIdea(rows)}</p>
</div>

<style>
  .idea-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
