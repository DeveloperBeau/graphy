<script>
  export let rows = [];

  function badgeAccent(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="cipher-badge">
  <p>{badgeAccent(rows)}</p>
</div>

<style>
  .cipher-badge {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
