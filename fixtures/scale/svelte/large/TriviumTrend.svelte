<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForTrivium(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="trivium-trend">
  <TrendSparkline />
  <p>{trendForTrivium(rows)}</p>
</div>

<style>
  .trivium-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
